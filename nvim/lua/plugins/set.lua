local opts = {
    backup = false,
    belloff = "all",
    clipboard = "unnamedplus",
    cmdheight = 1,
    colorcolumn = "100",
    completeopt = {"menuone", "noselect"},
    expandtab = true,
    foldexpr = 'nvim_treesitter#foldexpr()',
    foldmethod = 'expr',
    grepformat = "%f:%l:%c:%m",
    grepprg = "rg --vimgrep --no-heading --smart-case",
    hlsearch = false,
    ignorecase = true,
    inccommand = "split",
    incsearch = true,
    laststatus = 3,
    list = true,
    listchars = {eol = '﬋', tab = '» ', nbsp = '␣', trail = '•'},
    mouse = "nvi",
    nu = true,
    rnu = true,
    scrolloff = 8,
    shada = {"!", "'1000", "<50", "s10", "h"},
    shiftwidth = 4,
    showbreak = '↪',
    showmatch = true,
    signcolumn = "yes",
    smartcase = true,
    smartindent = true,
    softtabstop = 4,
    splitright = false,
    swapfile = false,
    tabstop = 4,
    termguicolors = true,
    undofile = true,
    updatetime = 250,
    winbar = "%f %m",
    wrap = true
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

local gopts = {
    floaterm_autoclose = 0,
    floaterm_width = 0.5,
    floaterm_wintype = 'vsplit',
    git_messenger_always_into_popup = true,
    git_messenger_floating_win_opts = {border = 'single', width = 70},
    git_messenger_popup_content_margins = false,
    global_colorscheme = 'tokyonight',
    lazygit_config_file_path = '~/.config/lazygit/config.yml',
    lazygit_floating_window_use_plenary = 0,
    lazygit_floating_window_winblend = 0,
    lazygit_use_custom_config_file_path = 1,
    mapleader = " ",
    maplocalleader = "\\",
    netrw_altv = 1,
    netrw_banner = 0,
    netrw_browse_split = 0,
    netrw_bufsettings = 'noma nomod nu nobl nowrap ro',
    netrw_winsize = 75,
    sessions_dir = '~/.local/share/nvim/session',
    tagbar_foldlevel = 2,
    tagbar_sort = 0,
    undotree_SetFocusWhenToggle = 1,
    vimwiki_list = {{path = '~/.vimwiki/'}}
    -- loaded_netrw = 1
    -- loaded_netrwPlugin = 1
}
if vim.g.neovide then
    table.insert(gopts, {
        neovide_cursor_trail_length = 0.8,
        neovide_cursor_animation_length = 0.04,
        neovide_transparency = 0.9
    })
end

for key, value in pairs(gopts) do vim.g[key] = value end

vim.g['conjure#client_on_load'] = false
vim.g['test#strategy'] = 'floaterm'
