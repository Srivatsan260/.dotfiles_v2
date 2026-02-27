return {
    {
        "ThePrimeagen/vim-be-good",
        lazy = true,
        keys = {
            { "<leader>vbg", "<cmd>VimBeGood<CR>", desc = "vimbegood" },
        },
    },
    {
        "Eandrju/cellular-automaton.nvim",
        lazy = true,
        keys = {
            { "<leader>cau", ":CellularAutomaton ", desc = "cellular automaton" },
        },
    },
    {
        "tpope/vim-speeddating",
        lazy = true,
        keys = { "<C-a>", "<C-x>", "g<C-a>", "g<C-x>" },
    },
    {
        "glts/vim-radical",
        dependencies = { "glts/vim-magnum" },
        lazy = true,
        keys = { "cr", "gA" },
    },
    {
        "m4xshen/hardtime.nvim",
        lazy = false,
        dependencies = { "MunifTanjim/nui.nvim" },
        opts = {
            disable_mouse = false,
        },
    },
}
