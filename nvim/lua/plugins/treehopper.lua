return {
    "mfussenegger/nvim-treehopper",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    lazy = true,
    keys = {
        {
            "<leader><CR>",
            function()
                require("tsht").nodes()
            end,
            desc = "hop nodes",
            mode = { "n", "v" },
        },
    },
}
