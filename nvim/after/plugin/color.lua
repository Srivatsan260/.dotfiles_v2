vim.opt.background = "dark"

vim.cmd(string.format("colorscheme %s", vim.g['global_colorscheme']))

vim.api.nvim_set_hl(0, "Folded", {bg = 'none', fg = '#78a9ff'})
vim.api.nvim_set_hl(0, "CursorLineNr", {bg = 'none', fg = '#78a9ff'})
