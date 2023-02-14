return {
    {
        "lukas-reineke/indent-blankline.nvim",
        event = {"BufReadPre", "BufNewFile"},
        opts = {
            -- char = "▏",
            char = "│",
            filetype_exclude = {
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
            },
            show_trailing_blankline_indent = false,
            show_current_context = false
        }
    },
    {
        "echasnovski/mini.indentscope",
        version = false, -- wait till new 0.7.0 release to put it back on semver
        event = {"BufReadPre", "BufNewFile"},
        opts = {
            -- symbol = "▏",
            symbol = "│",
            options = {try_as_border = true}
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
                },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end
            })
            require("mini.indentscope").setup(opts)
        end
    }
}
