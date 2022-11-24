require('staline').setup {
    defaults = {
        expand_null_ls = false, -- This expands out all the null-ls sources to be shown
        left_separator = "",
        right_separator = "",
        full_path = true,
        line_column = "[%l/%L] :%c %p%% ", -- `:h stl` to see all flags.

        fg = "#000000", -- Foreground text color.
        bg = "none", -- Default background is transparent.
        inactive_color = "none",
        inactive_bgcolor = "none",
        true_colors = true, -- true lsp colors.
        font_active = "none", -- "bold", "italic", "bold,italic", etc

        mod_symbol = "  ",
        lsp_client_symbol = " ",
        branch_symbol = " ",
    },
    mode_colors = {
        n = "#78a9ff",
        i = "#2bbb4f",
        c = "#e27d60",
        v = "#986fec",
        V = "#986fec"
    },
    mode_icons = {
        n = "NORMAL",
        i = "INSERT",
        c = "COMMAND",
        v = "VISUAL",
        V = "V-LINE",
        R = "REPLACE",
        s = "SELECT",
        t = "TERM",
    },
    sections = {
        left = {'-mode', 'left_sep_double', ' ', 'branch', ' ', 'lsp'},
        mid = {'file_name', ' ', 'file_size'},
        right = {'lsp_name', 'right_sep_double', 'line_column'}
    },
    special_table = {
        NvimTree = {'NvimTree', ' '},
        packer = {'Packer', ' '} -- etc
    },
    lsp_symbols = {Error = " ", Info = " ", Warn = " ", Hint = ""}
}
