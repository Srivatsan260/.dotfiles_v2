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
        { "<leader>gb", "<cmd>Git blame<CR>", desc = "blame using fugitive" },
        { "<leader>gp", "<cmd>Git pull --ff-only<CR>", desc = "git pull" },
        { "<leader>gP", "<cmd>Git push<CR>", desc = "git push" },
        { "<leader>gfa", "<cmd>Git fetch --all<CR>", desc = "git fetch --all" },
        { "<leader>gft", "<cmd>Git fetch --tags<CR>", desc = "git fetch --tags --force" },
        { "<leader>gsp", "<cmd>Git stash pop<CR>", desc = "git stash pop" }
    },
    cmd = { "Git", "GBrowse", "GRead", "GRemove", "GReset", "Gvdiffsplit" },
    lazy = true,
    config = function()
        vim.cmd("runtime! autoload/netrw/os.vim")
    end
}
