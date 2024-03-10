return {
    "ThePrimeagen/git-worktree.nvim",
    keys = {
        {
            "<leader>gws",
            function()
                local cmd_to_table = require("utils").cmd_to_table
                local root = string.gsub(
                    vim.fn.system('git worktree list --porcelain | head -1 | cut -d" " -f2'),
                    "[\n\r]",
                    ""
                )
                if root == nil then
                    print("error getting bare repo root!")
                    return
                end
                local branches = cmd_to_table("git branch -a")
                if rawequal(next(branches), nil) then
                    print("no branches!")
                    return
                end
                vim.ui.select(branches, { prompt = "select branch" }, function(branch)
                    local path = vim.fn.input({
                        prompt = "Enter worktree path from bare root: ",
                        default = "",
                    })
                    if path == "" then
                        return
                    end
                    local full_path = root .. "/" .. path
                    vim.fn.system("git worktree add " .. full_path .. " " .. branch)
                    require("git-worktree").switch_worktree(full_path)
                end)
            end,
            desc = "checkout existing branch as a new worktree",
        },
    },
    config = function()
        local worktree = require("git-worktree")
        worktree.setup({
            change_directory_command = "cd", -- default: "cd",
            update_on_change = true, -- default: true,
            update_on_change_command = "e .", -- default: "e .",
            clearjumps_on_change = true, -- default: true,
            autopush = false, -- default: false,
        })
        worktree.on_tree_change(function()
            -- todo: handle open term buffers when switching
            if vim.fn.glob(".editorconfig") ~= "" then
                pcall(require("lazy").load, { plugins = { "editorconfig.nvim" } })
            end
            local branch_name = vim.fn.system("!git rev-parse --abbrev-ref head")
            vim.cmd.clearjumps()
            local bufs = vim.api.nvim_list_bufs()
            local bufnr = vim.api.nvim_get_current_buf()
            for _, buf in ipairs(bufs) do
                if vim.api.nvim_buf_is_loaded(buf) and buf ~= bufnr then
                    local buf_name = vim.api.nvim_buf_get_name(buf)
                    if not string.find(buf_name, branch_name) then
                        vim.api.nvim_buf_delete(buf, {})
                    end
                end
            end
            if vim.api.nvim_buf_get_name(bufnr) ~= "" then
                vim.cmd([[ e ]])
            end
        end)
    end,
}
