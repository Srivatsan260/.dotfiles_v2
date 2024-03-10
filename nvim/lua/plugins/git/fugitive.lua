return {
    "tpope/vim-fugitive",
    dependencies = {
        "tommcdo/vim-fubitive",
        "tpope/vim-rhubarb",
    },
    keys = {
        { "<leader>G", "<cmd>Git<CR>", desc = "open fugitive" },
        { "<leader>gn", ":Git checkout -b ", desc = "checkout new branch" },
        { "<leader>gc", "<cmd>Git commit<CR>", desc = "commit using fugitive" },
    },
    cmd = { "Git", "GBrowse", "GRead", "GRemove", "GReset", "Gvdiffsplit" },
    lazy = true,
}
