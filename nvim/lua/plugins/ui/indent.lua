return {
    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufEnter", "BufNewFile" },
        enabled = false,
        main = "ibl",
        opts = {
            debounce = 100,
            indent = { char = "┋", },
            whitespace = { highlight = { "Whitespace", "NonText" } },
            scope = { exclude = { language = { "lua" } } },
        }
    },
    {
        "echasnovski/mini.indentscope",
        enabled = true,
        version = false, -- wait till new 0.7.0 release to put it back on semver
        event = { "BufEnter", "BufNewFile" },
        opts = {
            -- symbol = "▏",
            symbol = "│",
            options = { try_as_border = true },
        },
        config = function(_, opts)
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "help",
                    "alpha",
                    "dashboard",
                    "neo-tree",
                    "Trouble",
                    "lazy",
                    "mason",
                    "undotree",
                    "qf",
                    "netrw",
                    "fugitive",
                    "Outline",
                    "gitmessengerpopup",
                },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
            require("mini.indentscope").setup(opts)
        end,
    },
}
