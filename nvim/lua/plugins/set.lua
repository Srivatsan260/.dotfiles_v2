local opts = {
    nu = true,
    rnu = true,
    showmatch = true,
    belloff = "all",
    tabstop = 4,
    softtabstop = 4,
    shiftwidth = 4,
    expandtab = true,
    ignorecase = true,
    smartcase = true,
    hlsearch = false,
    incsearch = true,
    scrolloff = 8,
    signcolumn = "yes",
    swapfile = false,
    backup = false,
    termguicolors = true,
    clipboard = "unnamedplus",
    undofile = true,
    inccommand = "split",
    shada = {"!", "'1000", "<50", "s10", "h"},
    smartindent = true,
    wrap = true,
    updatetime = 250,
    colorcolumn = "100",
    cmdheight = 1,
    splitright = false,
    grepprg = "rg --vimgrep --no-heading --smart-case",
    grepformat = "%f:%l:%c:%m",
    winbar = "%f %m",
    mouse = "nvi",
    laststatus = 3,
    list = true,
    listchars = {eol = '﬋', tab = '» ', nbsp = '␣', trail = '•'},
    showbreak = '↪',
    foldmethod = 'expr',
    foldexpr = 'nvim_treesitter#foldexpr()',
    completeopt = {"menuone", "noselect"}
}
for key, value in pairs(opts) do vim.opt[key] = value end

vim.opt.formatoptions = vim.opt.formatoptions - "a" -- Auto formatting is BAD.
- "t" -- Don't auto format my code. I got linters for that.
+ "c" -- When comments respect textwidth
+ "q" -- Allow formatting comments w/ gq
- "o" -- O and o, don't continue comments
+ "r" -- But do continue when pressing enter.
+ "n" -- Indent past the formatlistpat, not underneath it.
+ "j" -- Auto-remove comments if possible.
- "2" -- Don't use indent of 2nd line of paragraph for the rest of it

vim.opt.jumpoptions = vim.opt.jumpoptions + "stack"

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
vim.g.floaterm_autoclose = 0
vim.g.git_messenger_always_into_popup = true
vim.g.git_messenger_floating_win_opts = {border = 'single', width = 70}
vim.g.git_messenger_popup_content_margins = false
vim.g.vimwiki_list = {{path = '~/.vimwiki/'}}
vim.g['conjure#client_on_load'] = false
vim.g['test#strategy'] = 'floaterm'
vim.g.tagbar_sort = 0
vim.g.tagbar_foldlevel = 2
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

if vim.g.neovide then
    vim.g.neovide_cursor_trail_length = 0.8
    vim.g.neovide_cursor_animation_length = 0.04
    vim.g.neovide_transparency = 0.9
end
