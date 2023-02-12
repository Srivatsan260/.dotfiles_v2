return {
    'ckolkey/ts-node-action',
    dependencies = {
        'nvim-treesitter/nvim-treesitter'
    },
    lazy = true,
    keys = {
        {
            "<leader>ta",
            function() require("ts-node-action").node_action() end,
            desc = "Trigger Node Action"
        }
    }
}
