return {
    'ziontee113/icon-picker.nvim',
    opts = {
        disable_legacy_commands = true
    },
    lazy = true,
    keys = {
        {"<leader>ici", "<cmd>IconPickerInsert<CR>", desc = "icon picker (insert)"},
        {"<leader>icn", "<cmd>IconPickerNormal<CR>", desc = "icon picker (normal)"},
        {"<leader>icy", "<cmd>IconPickerYank<CR>", desc = "icon picker (yank)"},
    }
}
