return {
    {
        'tpope/vim-dadbod',
        dependencies = {
            'kristijanhusak/vim-dadbod-ui',
            'kristijanhusak/vim-dadbod-completion',
        },
        lazy = true,
        keys = {
            {"<leader>DB", "<cmd>DBUI<CR>", desc = "Open the DADBOD UI"},
        }
    }
}
