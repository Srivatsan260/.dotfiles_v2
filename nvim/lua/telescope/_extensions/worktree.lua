local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local conf = require("telescope.config").values
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local telescope = require("telescope")

local M = {}

local title = "git-worktree"

local function notify(message, level)
    vim.notify(message, level or vim.log.levels.INFO, { title = title })
end

local function normalize(path)
    return vim.fs.normalize(vim.fn.fnamemodify(path, ":p"))
end

local function git_context(path)
    if not path or path == "" then
        return nil
    end

    local output = vim.fn.systemlist({
        "git",
        "-C",
        path,
        "rev-parse",
        "--path-format=absolute",
        "--git-common-dir",
    })
    local code = vim.v.shell_error

    if code ~= 0 or not output[1] or output[1] == "" then
        return nil
    end

    return normalize(path)
end

local function repo_cwd()
    if M._repo_cwd then
        local cached = git_context(M._repo_cwd)
        if cached then
            M._repo_cwd = cached
            return cached
        end
    end

    local candidates = { vim.loop.cwd() }
    local current_file = vim.api.nvim_buf_get_name(0)
    if current_file ~= "" then
        table.insert(candidates, vim.fs.dirname(current_file))
    end

    for _, candidate in ipairs(candidates) do
        local resolved = git_context(candidate)
        if resolved then
            M._repo_cwd = resolved
            return resolved
        end
    end

    return nil
end

local function shell_join(parts)
    return table.concat(vim.tbl_map(vim.fn.shellescape, parts), " ")
end

local function run_git(args, opts)
    opts = opts or {}
    local cmd = { "git" }
    local cwd = opts.cwd or repo_cwd()

    if cwd and cwd ~= "" then
        table.insert(cmd, "-C")
        table.insert(cmd, cwd)
    end

    vim.list_extend(cmd, args)

    local output = vim.fn.systemlist(cmd)
    local code = vim.v.shell_error

    if opts.notify_on_error ~= false and code ~= 0 then
        local message = table.concat(output, "\n")
        if message == "" then
            message = "git command failed: " .. shell_join(cmd)
        end
        notify(message, vim.log.levels.ERROR)
    end

    return code, output
end

local function current_root(cwd)
    local code, output = run_git({ "rev-parse", "--show-toplevel" }, { cwd = cwd, notify_on_error = false })
    if code ~= 0 or not output[1] or output[1] == "" then
        return nil
    end

    return normalize(output[1])
end

local function current_context_path()
    local current_path = vim.api.nvim_buf_get_name(0)
    if current_path ~= "" then
        return normalize(current_path)
    end

    return normalize(vim.loop.cwd())
end

local function find_current_worktree(worktrees)
    local context_path = current_context_path()
    local best_match = nil

    for _, worktree in ipairs(worktrees) do
        if not worktree.bare then
            local root = normalize(worktree.path)
            local prefix = root .. "/"
            if context_path == root or context_path:sub(1, #prefix) == prefix then
                if not best_match or #root > #best_match.path then
                    best_match = worktree
                end
            end
        end
    end

    return best_match
end

local function worktree_base_dir(main_worktree)
    if main_worktree.bare then
        return normalize(main_worktree.path)
    end

    return vim.fs.dirname(normalize(main_worktree.path))
end

local function parse_worktrees(lines)
    local worktrees = {}
    local current = nil

    local function flush()
        if current and current.path then
            current.path = normalize(current.path)
            table.insert(worktrees, current)
        end
        current = nil
    end

    for _, line in ipairs(lines) do
        if line == "" then
            flush()
        elseif vim.startswith(line, "worktree ") then
            flush()
            current = { path = line:sub(10) }
        elseif current and vim.startswith(line, "branch ") then
            current.branch = line:sub(8):gsub("^refs/heads/", "")
        elseif current and vim.startswith(line, "HEAD ") then
            current.head = line:sub(6)
        elseif current and line == "bare" then
            current.bare = true
        elseif current and line == "detached" then
            current.detached = true
        elseif current and vim.startswith(line, "locked") then
            current.locked = line
        elseif current and vim.startswith(line, "prunable") then
            current.prunable = line
        end
    end

    flush()

    return worktrees
end

local function list_worktrees()
    local code, output = run_git({ "worktree", "list", "--porcelain" })
    if code ~= 0 then
        return nil
    end

    local worktrees = parse_worktrees(output)
    if worktrees[1] then
        M._repo_cwd = normalize(worktrees[1].path)
    end

    local current_worktree = find_current_worktree(worktrees)

    for _, worktree in ipairs(worktrees) do
        worktree.is_current = current_worktree ~= nil and normalize(worktree.path) == normalize(current_worktree.path)
    end

    return worktrees
end

local function list_branches()
    local code, output = run_git({ "for-each-ref", "--format=%(refname:short)", "refs/heads", "refs/remotes" })
    if code ~= 0 then
        return nil
    end

    local branches = {}
    local seen = {}

    for _, branch in ipairs(output) do
        if branch ~= "" and not branch:match("/HEAD$") and not seen[branch] then
            seen[branch] = true
            table.insert(branches, branch)
        end
    end

    table.sort(branches)

    return branches
end

local function same_path_in_worktree(target_path)
    local current_path = vim.api.nvim_buf_get_name(0)
    if current_path == "" then
        return nil
    end

    local worktrees = list_worktrees()
    if not worktrees then
        return nil
    end

    local current_worktree = find_current_worktree(worktrees)
    if not current_worktree then
        return nil
    end

    local root = normalize(current_worktree.path)
    local path = normalize(current_path)
    local prefix = root .. "/"
    if path ~= root and path:sub(1, #prefix) ~= prefix then
        return nil
    end

    local relative_path = path == root and "" or path:sub(#prefix + 1)
    local target = relative_path == "" and normalize(target_path) or normalize(target_path .. "/" .. relative_path)

    if vim.fn.filereadable(target) == 1 or vim.fn.isdirectory(target) == 1 then
        return target
    end

    return nil
end

local function switch_to_worktree(path)
    local target_path = normalize(path)
    local target_buffer_path = same_path_in_worktree(target_path)

    M._repo_cwd = target_path

    vim.cmd("cd " .. vim.fn.fnameescape(target_path))

    if target_buffer_path then
        vim.cmd("edit " .. vim.fn.fnameescape(target_buffer_path))
    else
        vim.cmd("edit " .. vim.fn.fnameescape(target_path))
    end

    notify("Switched to " .. target_path)
end

local function resolve_new_path(main_worktree, input)
    if not input or input == "" then
        return nil
    end

    if vim.startswith(input, "~") then
        return normalize(vim.fn.expand(input))
    end

    if vim.startswith(input, "/") then
        return normalize(input)
    end

    return normalize(worktree_base_dir(main_worktree) .. "/" .. input)
end

local function create_worktree(callback)
    local worktrees = list_worktrees()
    if not worktrees or vim.tbl_isempty(worktrees) then
        notify("No git worktrees available", vim.log.levels.WARN)
        return
    end

    local branches = list_branches()
    if not branches or vim.tbl_isempty(branches) then
        notify("No git branches found", vim.log.levels.WARN)
        return
    end

    local main_worktree = worktrees[1]
    local default_dir = worktree_base_dir(main_worktree) .. "/"

    vim.ui.select({ "new branch", "existing branch" }, { prompt = "Create worktree from" }, function(mode)
        if not mode then
            return
        end

        vim.ui.select(branches, { prompt = mode == "new branch" and "Base branch" or "Branch" }, function(selected_branch)
            if not selected_branch or selected_branch == "" then
                return
            end

            local default_path = default_dir .. selected_branch:gsub("[/%s]+", "-")
            vim.ui.input({
                prompt = "Worktree path: ",
                default = default_path,
                completion = "dir",
            }, function(path_input)
                local path = resolve_new_path(main_worktree, path_input)
                if not path then
                    return
                end

                local args = { "worktree", "add" }

                local function finish()
                    if callback then
                        callback()
                    end
                    switch_to_worktree(path)
                end

                if mode == "new branch" then
                    vim.ui.input({ prompt = "New branch name: ", default = "" }, function(new_branch)
                        if not new_branch or new_branch == "" then
                            return
                        end

                        vim.list_extend(args, { "-b", new_branch, path, selected_branch })
                        local code = run_git(args)
                        if code == 0 then
                            finish()
                        end
                    end)
                else
                    vim.list_extend(args, { path, selected_branch })
                    local code = run_git(args)
                    if code == 0 then
                        finish()
                    end
                end
            end)
        end)
    end)
end

local function delete_worktree(worktree, callback)
    vim.ui.input({
        prompt = "Type 'yes' to delete " .. worktree.path .. ": ",
        default = "no",
    }, function(input)
        if input ~= "yes" then
            notify("Deletion cancelled")
            return
        end

        local code = run_git({ "worktree", "remove", worktree.path })
        if code == 0 then
            notify("Deleted " .. worktree.path)
            if callback then
                callback()
            end
        end
    end)
end

local function format_flags(item)
    local flags = {}
    if item.is_current then
        table.insert(flags, "current")
    end
    if item.bare then
        table.insert(flags, "bare")
    end
    if item.detached then
        table.insert(flags, "detached")
    end
    if item.locked then
        table.insert(flags, "locked")
    end

    return #flags > 0 and table.concat(flags, ",") or ""
end

local function open_picker(opts)
    opts = opts or {}
    local worktrees = list_worktrees()
    if not worktrees or vim.tbl_isempty(worktrees) then
        notify("No git worktrees found", vim.log.levels.WARN)
        return
    end

    local results = {}
    for _, worktree in ipairs(worktrees) do
        if not worktree.bare and (not opts.exclude_current or not worktree.is_current) then
            table.insert(results, worktree)
        end
    end

    if vim.tbl_isempty(results) then
        notify("No matching git worktrees found", vim.log.levels.WARN)
        return
    end

    pickers.new(opts, {
        prompt_title = opts.mode == "delete" and "Delete Git Worktree" or "Git Worktrees",
        finder = finders.new_table({
            results = results,
            entry_maker = function(item)
                local branch = item.branch or (item.detached and "detached") or "unknown"
                local flags = format_flags(item)
                local label = branch
                if flags ~= "" then
                    label = string.format("%s [%s]", branch, flags)
                end

                return {
                    value = item,
                    ordinal = table.concat({ branch, item.path, flags }, " "),
                    display = label,
                }
            end,
        }),
        previewer = false,
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, map)
            local function refresh_picker()
                vim.schedule(function()
                    open_picker(opts)
                end)
            end

            actions.select_default:replace(function()
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                if selection and selection.value then
                    if opts.mode == "delete" then
                        delete_worktree(selection.value, function()
                            vim.schedule(function()
                                open_picker(opts)
                            end)
                        end)
                    else
                        switch_to_worktree(selection.value.path)
                    end
                end
            end)

            map({ "i", "n" }, "<C-a>", function()
                actions.close(prompt_bufnr)
                create_worktree(function()
                    vim.schedule(function()
                        open_picker(opts)
                    end)
                end)
            end)

            map({ "i", "n" }, "<C-d>", function()
                local selection = action_state.get_selected_entry()
                if not selection or not selection.value or selection.value.is_current then
                    notify("Select a non-current worktree to delete", vim.log.levels.WARN)
                    return
                end

                actions.close(prompt_bufnr)
                delete_worktree(selection.value, refresh_picker)
            end)

            return true
        end,
    }):find()
end

function M.worktrees(opts)
    open_picker(opts)
end

function M.create()
    create_worktree(function()
        vim.schedule(function()
            open_picker({})
        end)
    end)
end

function M.delete()
    open_picker({ exclude_current = true, mode = "delete" })
end

return telescope.register_extension({
    exports = {
        worktrees = M.worktrees,
        create = M.create,
        delete = M.delete,
    },
})
