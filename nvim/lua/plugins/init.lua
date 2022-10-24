require("plugins.set")
require("plugins.packer")
require("plugins.remap")
require("plugins.lualine")
require("plugins.lsp")
require("plugins.telescope")
require("plugins.dap")
require("plugins.comment")
if string.find(vim.g['global_colorscheme'], 'tokyonight') then
    require("plugins.tokyonight")
end
require('plugins.impatient')
require('plugins.cursorline')
-- require('plugins.nvim_tree')
