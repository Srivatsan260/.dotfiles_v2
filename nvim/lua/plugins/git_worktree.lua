require("git-worktree").setup(
    {
        change_directory_command = "cd", -- default: "cd",
        update_on_change = true, -- default: true,
        update_on_change_command = "e .", -- default: "e .",
        clearjumps_on_change = true, -- default: true,
        autopush = false -- default: false,
    }
)

local worktree = require("git-worktree")
worktree.on_tree_change(
    function()
        -- TODO investigate any edge cases
        local branch_name = vim.fn.system("!git rev-parse --abbrev-ref HEAD")
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
        if vim.api.nvim_buf_get_name(bufnr) ~= "" then vim.cmd [[ e ]] end
    end
)
