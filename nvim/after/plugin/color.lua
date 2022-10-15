vim.g.tokyonight_transparent_sidebar = true
vim.g.tokyonight_transparent = true
vim.g.base16_transparent_background = true
vim.opt.background = "dark"

vim.cmd(string.format("colorscheme %s", vim.g['global_colorscheme']))
