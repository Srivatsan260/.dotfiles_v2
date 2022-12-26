-- disable built-in local config file support
vim.o.exrc = false

require("exrc").setup({files = {".exrc.lua", ".exrc"}})
