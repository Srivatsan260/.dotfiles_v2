require("git-worktree").setup({
    change_directory_command = "cd", -- default: "cd",
    update_on_change = true, -- default: true,
    update_on_change_command = "e .", -- default: "e .",
    clearjumps_on_change = true, -- default: true,
    autopush = false, -- default: false,
})

local worktree = require("git-worktree")
worktree.on_tree_change(function()
    vim.cmd.clearjumps()
    -- TODO fix the below code block
    -- local bufs = vim.api.nvim_list_bufs()
    -- local bufnr = vim.api.nvim_get_current_buf()
    -- print("current_buf" .. bufnr)
    -- for _, buf in ipairs(bufs) do
    --     if vim.api.nvim_buf_is_loaded(buf) and buf ~= bufnr then
    --         print("deleting " .. buf)
    --         vim.api.nvim_buf_delete(buf, {})
    --     end
    -- end
    -- vim.cmd [[ e ]]
end)
