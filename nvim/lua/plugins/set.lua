vim.g['netrw_altv'] = 1
vim.g['netrw_banner'] = 0
vim.g['netrw_browse_split'] = 0
vim.g['netrw_winsize'] = 75
vim.g['netrw_bufsettings'] = 'noma nomod nu nobl nowrap ro'
vim.g['global_colorscheme'] = 'tokyonight'
vim.g['sessions_dir'] = '~/.local/share/nvim/session'
vim.g['lazygit_floating_window_winblend'] = 10
vim.g['undotree_SetFocusWhenToggle'] = 1
vim.g['floaterm_wintype'] = 'vsplit'
vim.g['floaterm_width'] = 0.5

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"

vim.opt.smartindent = true
vim.opt.wrap = true
vim.g.mapleader = " "
vim.opt.updatetime = 50

vim.opt.colorcolumn = "100"
vim.opt.cmdheight = 1
vim.opt.splitright = false
vim.opt.grepprg="rg --vimgrep --no-heading --smart-case"
vim.opt.grepformat="%f:%l:%c:%m"

vim.opt.winbar="%f %m"
vim.opt.lazyredraw=true
vim.opt.mouse="nvi"
vim.opt.laststatus=3
