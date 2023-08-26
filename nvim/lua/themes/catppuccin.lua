local M = {}

local theme_opts = {
    flavour = "macchiato", -- latte, frappe, macchiato, mocha
    transparent_background = true,
    term_colors = true,
    dim_inactive = { enabled = false, shade = "dark", percentage = 0.15 },
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    color_overrides = {},
    custom_highlights = function(_)
        return { WinSeparator = { bg = "none", fg = "#78a9ff" } }
    end,
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        notify = false,
        mini = false,
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
}

M.setup = function()
    require("catppuccin").setup(theme_opts)
    vim.cmd.colorscheme("catppuccin")
end

return M
