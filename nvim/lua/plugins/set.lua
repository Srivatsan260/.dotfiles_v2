vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.netrw_altv = 1
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 0
vim.g.netrw_winsize = 75
vim.g.netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
vim.g.global_colorscheme = 'tokyonight'
vim.g.sessions_dir = '~/.local/share/nvim/session'
vim.g.lazygit_floating_window_winblend = 0
vim.g.lazygit_floating_window_use_plenary = 0
vim.g.lazygit_use_custom_config_file_path = 1
vim.g.lazygit_config_file_path = '~/.config/lazygit/config.yml'
vim.g.undotree_SetFocusWhenToggle = 1
vim.g.floaterm_wintype = 'vsplit'
vim.g.floaterm_width = 0.5
vim.g.git_messenger_always_into_popup = true
vim.g.git_messenger_floating_win_opts = {border = 'single', width=70}
vim.g.git_messenger_popup_content_margins = false
vim.g.vimwiki_list = {{path = '~/.vimwiki/'}}
vim.g['conjure#client_on_load'] = false
vim.g['test#strategy'] = 'floaterm'
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

if vim.g.neovide then
    vim.g.neovide_cursor_trail_length = 0.8
    vim.g.neovide_cursor_animation_length = 0.04
    vim.g.neovide_transparency = 0.9
end

vim.opt.nu = true
vim.opt.rnu = true

vim.opt.showmatch = true
vim.opt.belloff = "all"
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true
vim.opt.inccommand = "split"
vim.opt.shada = {"!", "'1000", "<50", "s10", "h"}

vim.opt.smartindent = true
vim.opt.wrap = true
vim.opt.updatetime = 250

vim.opt.colorcolumn = "81"
vim.opt.cmdheight = 1
vim.opt.splitright = false
vim.opt.grepprg = "rg --vimgrep --no-heading --smart-case"
vim.opt.grepformat = "%f:%l:%c:%m"

vim.opt.winbar = "%f %m"
vim.opt.mouse = "nvi"
vim.opt.laststatus = 3

vim.opt.list = true
vim.opt.listchars = {eol = '﬋', tab = '» ', nbsp = '␣', trail = '•'}
vim.opt.showbreak = '↪'

vim.opt.formatoptions = vim.opt.formatoptions - "a" -- Auto formatting is BAD.
- "t" -- Don't auto format my code. I got linters for that.
+ "c" -- When comments respect textwidth
+ "q" -- Allow formatting comments w/ gq
- "o" -- O and o, don't continue comments
+ "r" -- But do continue when pressing enter.
+ "n" -- Indent past the formatlistpat, not underneath it.
+ "j" -- Auto-remove comments if possible.
- "2" -- Don't use indent of 2nd line of paragraph for the rest of it

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
