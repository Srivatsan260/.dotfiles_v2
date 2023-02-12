return {
    {
        'ThePrimeagen/vim-be-good',
        lazy = true,
        keys = {
            {"<leader>vbg", "<cmd>VimBeGood<CR>", desc = "vimbegood"},
        }
    },
    {
        'Eandrju/cellular-automaton.nvim',
        lazy = true,
        keys = {
            {"<leader>cau", ":CellularAutomaton ", desc = "cellular automaton"},
        }
    },
    'tpope/vim-speeddating',
    {'glts/vim-radical', dependencies = {'glts/vim-magnum'}},
    'tpope/vim-eunuch',
}
