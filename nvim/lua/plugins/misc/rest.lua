return {
    "rest-nvim/rest.nvim",
    enabled = false,
    dependencies = {
        {
            "nvim-treesitter/nvim-treesitter",
            opts = function(_, opts)
                opts.ensure_installed = opts.ensure_installed or {}
                table.insert(opts.ensure_installed, "http")
            end,
        },
        { "nvim-neotest/nvim-nio" },
    },
}
