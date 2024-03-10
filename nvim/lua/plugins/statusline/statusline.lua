return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "kyazdani42/nvim-web-devicons",
            "folke/noice.nvim",
        },
        event = "VeryLazy",
        config = function()
            local lualine = require("lualine")
            lualine.setup({
                -- "┃", "█", "", "", "", "", "", "", "●"
                options = {
                    icons_enabled = true,
                    component_separators = { left = "", right = "" },
                    section_separators = { left = "", right = "" },
                    disabled_filetypes = { statusline = {}, winbar = {} },
                    ignore_focus = {},
                    always_divide_middle = true,
                    globalstatus = true,
                    refresh = { statusline = 1000, tabline = 1000, winbar = 1000 },
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = {
                        "branch",
                        -- {
                        --     require("noice").api.statusline.mode.get,
                        --     cond = require("noice").api.statusline.mode.has,
                        --     color = { fg = "#ff0312" }
                        -- }
                    },
                    lualine_c = {
                        "%=",
                        { "filename", path = 0 },
                        "filesize",
                        "diff",
                        "diagnostics",
                    },
                    lualine_x = {
                        "encoding",
                        "fileformat",
                        "filetype",
                    },
                    lualine_y = { "location", "progress" },
                    lualine_z = { "" },
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {},
                },
                tabline = {},
                winbar = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { { "filename", path = 1 } },
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {},
                },
                inactive_winbar = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { { "filename", path = 1 } },
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {},
                },
                extensions = { "fugitive", "fzf", "man", "nvim-dap-ui", "quickfix" },
            })
        end,
    },
}
