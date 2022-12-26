require("themes." .. vim.g["global_colorscheme"])
vim.cmd(string.format("colorscheme %s", vim.g['global_colorscheme']))

vim.api.nvim_set_hl(0, "Folded", {bg = 'none', fg = '#78a9ff'})
vim.api.nvim_set_hl(0, "CursorLineNr", {bg = 'none', fg = '#78a9ff'})

-- TODO: figure out how to do this using nvim_get_hl_by_name
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", {bg = 'none', fg = '#db4b4b'})
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", {bg = 'none', fg = '#e0af68'})
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", {bg = 'none', fg = '#0db9d7'})
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", {bg = 'none', fg = '#1abc9c'})

vim.cmd("Gitsigns toggle_linehl")
vim.cmd("Gitsigns toggle_numhl")
