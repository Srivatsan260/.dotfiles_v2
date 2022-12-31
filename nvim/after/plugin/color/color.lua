pcall(require, "themes." .. vim.g["global_colorscheme"])
vim.cmd(string.format("colorscheme %s", vim.g['global_colorscheme']))

vim.api.nvim_set_hl(0, "TroubleNormal", {bg = "none"})
