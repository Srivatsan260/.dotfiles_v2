return {
    "mfussenegger/nvim-treehopper",
    enabled = false,
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
