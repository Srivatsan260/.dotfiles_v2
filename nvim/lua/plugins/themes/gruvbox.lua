return {
    "ellisonleao/gruvbox.nvim",
    event = "ColorSchemePre",
    opts = {
        terminal_colors = true, -- add neovim terminal colors
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
            strings = true,
            emphasis = true,
            comments = true,
            operators = false,
            folds = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true, -- invert background for search, diffs, statuslines and errors
        dim_inactive = false,
        transparent_mode = true,
        contrast = "hard",
        palette_overrides = {dark0_hard = "#0E1018"},
        overrides = {
            -- Comment = {fg = "#626A73", italic = true, bold = true},
            -- #736B62,  #626273, #627273 
            Comment = {fg = "#81878f", italic = true, bold = true},
            Define = {link = "GruvboxPurple"},
            Macro = {link = "GruvboxPurple"},
            ["@constant.builtin"] = {link = "GruvboxPurple"},
            ["@storageclass.lifetime"] = {link = "GruvboxAqua"},
            ["@text.note"] = {link = "TODO"},
            ["@namespace.latex"] = {link = "Include"},
            ["@namespace.rust"] = {link = "Include"},
            ContextVt = {fg = "#878788"},
            CopilotSuggestion = {fg = "#878787"},
            DiagnosticVirtualTextWarn = {fg = "#dfaf87"},
            -- fold
            Folded = {fg = "#1260a9", bg = "#3c3836", italic = true},
            FoldColumn = {fg = "#1260a9", bg = "#0E1018"},
            SignColumn = {bg = nil},
            -- new git colors
            DiffAdd = { bold = true, reverse = false, fg = "", bg = "#2a4333"},
            DiffChange = { bold = true, reverse = false, fg = "", bg = "#333841" },
            DiffDelete = { bold = true, reverse = false, fg = "#442d30", bg = "#442d30" },
            DiffText = { bold = true, reverse = false, fg = "", bg = "#213352" },
            -- statusline
            StatusLine = {bg = "#ffffff", fg = "#0E1018"},
            StatusLineNC = {bg = "#3c3836", fg = "#0E1018"},
            CursorLineNr = {fg = "#fabd2f", bg = ""},
            GruvboxOrangeSign = {fg = "#dfaf87", bg = ""},
            GruvboxAquaSign = {fg = "#8EC07C", bg = ""},
            GruvboxGreenSign = {fg = "#b8bb26", bg = ""},
            GruvboxRedSign = {fg = "#fb4934", bg = ""},
            GruvboxBlueSign = {fg = "#83a598", bg = ""},
            WilderMenu = {fg = "#ebdbb2", bg = ""},
            WilderAccent = {fg = "#f4468f", bg = ""},
        }
    }
}
