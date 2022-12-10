local colors = {
    black = "#000000",
    default = "#78A9FF",
    innerbg = nil,
    outerbg = nil,
    normal = "#78A9FF",
    insert = "#98EE6C",
    visual = "#FF90C9",
    replace = "#E46876",
    command = "#FFC07A",
    terminal = '#00FFFF'
}
local theme = {
    inactive = {
        a = {fg = colors.default, bg = colors.outerbg, gui = "bold"},
        b = {fg = colors.default, bg = colors.outerbg},
        c = {fg = colors.default, bg = colors.innerbg}
    },
    visual = {
        a = {fg = colors.black, bg = colors.visual, gui = "bold"},
        b = {fg = colors.visual, bg = colors.outerbg},
        c = {fg = colors.visual, bg = colors.innerbg}
    },
    replace = {
        a = {fg = colors.black, bg = colors.replace, gui = "bold"},
        b = {fg = colors.replace, bg = colors.outerbg},
        c = {fg = colors.replace, bg = colors.innerbg}
    },
    normal = {
        a = {fg = colors.black, bg = colors.normal, gui = "bold"},
        b = {fg = colors.normal, bg = colors.outerbg},
        c = {fg = colors.normal, bg = colors.innerbg}
    },
    insert = {
        a = {fg = colors.black, bg = colors.insert, gui = "bold"},
        b = {fg = colors.insert, bg = colors.outerbg},
        c = {fg = colors.insert, bg = colors.innerbg}
    },
    command = {
        a = {fg = colors.black, bg = colors.command, gui = "bold"},
        b = {fg = colors.command, bg = colors.outerbg},
        c = {fg = colors.command, bg = colors.innerbg}
    },
    terminal = {
        a = {fg = colors.black, bg = colors.terminal, gui = "bold"},
        b = {fg = colors.terminal, bg = colors.outerbg},
        c = {fg = colors.terminal, bg = colors.innerbg}
    }
}

require('lualine').setup {
    -- "┃", "█", "", "", "", "", "", "", "●"
    options = {
        icons_enabled = true,
        theme = theme,
        component_separators = {left = '', right = ''},
        section_separators = {left = '', right = ''},
        disabled_filetypes = {statusline = {}, winbar = {}},
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh = {statusline = 1000, tabline = 1000, winbar = 1000}
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch'},
        lualine_c = {
            '%=', {'filename', path = 0}, 'filesize', 'diff', 'diagnostics'
        },
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'location', 'progress'},
        lualine_z = {''}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    -- extensions = {'nvim-tree'}
    extensions = {}
}
