return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    module = true,
    opts = { signs = false },
    lazy = true,
    keys = {
        {
            "]t",
            function()
                require("todo-comments").jump_next({ keywords = { "FIX", "INFO", "TODO", "NOTE", "WARNING" } })
            end,
            desc = "Next todo comment",
        },
        {
            "[t",
            function()
                require("todo-comments").jump_prev({ keywords = { "FIX", "INFO", "TODO", "NOTE", "WARNING" } })
            end,
            desc = "Previous todo comment",
        },
        { "<leader>td", "<cmd>TodoTelescope<CR>", desc = "Open TODOs in telescope" },
    },
}
