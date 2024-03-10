return {
    "Jxstxs/conceal.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
    opts = {
        --[[ ["language"] = {
            enabled = bool,
            ["keyword"] = {
                enabled     = bool,
                conceal     = string,
                highlight   = string
            }
        } ]]
        ["lua"] = {
            ["local"] = {
                enabled = true, -- to disable concealing for "local"
                conceal = "l",
            },
            ["return"] = {
                conceal = "R", -- to set the concealing to "R"
            },
            ["for"] = {
                highlight = "keyword", -- to set the Highlight group to "@keyword"
            },
        },
    },
    keys = {
        {
            "<localleader>cc",
            function()
                require("conceal").toggle_conceal(1)
            end,
            silent = true,
            desc = "Toggle conceals",
        },
        {
            "<leader>cg",
            function()
                require("conceal").generate_conceals()
            end,
            desc = "Generate conceals",
        },
    },
}
