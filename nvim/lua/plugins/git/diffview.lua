return {
    "sindrets/diffview.nvim",
    keys = {
        { "<leader>dvh", "<cmd>DiffviewOpen HEAD~1<CR>", desc = "dif HEAD with HEAD~1" },
        { "<leader>dvH", ":DiffviewOpen HEAD~", desc = "diff HEAD with HEAD~n" },
        { "<leader>dvl", "<cmd>DiffviewFileHistory<CR>", desc = "git log in diff window" },
        { "<leader>dvo", "<cmd>DiffviewOpen<CR>", desc = "open Diffview" },
        { "<leader>dvc", "<cmd>DiffviewClose<CR>", desc = "close Diffview" },
    },
    lazy = true,
}
