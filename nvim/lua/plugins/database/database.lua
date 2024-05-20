return {
    {
        "tpope/vim-dadbod",
        dependencies = {
            "kristijanhusak/vim-dadbod-ui",
            "kristijanhusak/vim-dadbod-completion",
        },
        enabled = false,
        lazy = true,
        keys = {
            { "<leader>DB", "<cmd>DBUI<CR>", desc = "Open the DADBOD UI" },
        },
    },
}
