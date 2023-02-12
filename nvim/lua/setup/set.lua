local opts = {
    background = "dark",
    backup = false,
    belloff = "all",
    clipboard = "unnamedplus",
    cmdheight = 1,
    colorcolumn = "100",
    completeopt = {"menuone", "noselect"},
    conceallevel = 1,
    expandtab = true,
    exrc = true,
    foldexpr = 'nvim_treesitter#foldexpr()',
    foldmethod = 'expr',
    grepformat = "%f:%l:%c:%m",
    grepprg = "rg --vimgrep --no-heading --smart-case",
    guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20",
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
    showmode = false,
    signcolumn = "yes",
    smartcase = true,
    smartindent = true,
    softtabstop = 4,
    splitright = false,
    swapfile = false,
    tabstop = 4,
    termguicolors = true,
    timeoutlen = 250,
    undofile = true,
    updatetime = 250,
    -- winbar = "%f %m",
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

local themes = require("themes").themes

local global_opts = {
    global_colorscheme = themes.tokyonight,
    mapleader = " ",
    maplocalleader = "\\",
    netrw_altv = 1,
    netrw_banner = 0,
    netrw_browse_split = 0,
    netrw_bufsettings = 'noma nomod nu nobl nowrap ro',
    netrw_winsize = 75,
    sessions_dir = '~/.local/share/nvim/session',
}
if vim.g.neovide then
    table.insert(global_opts, {
        neovide_cursor_trail_length = 0.8,
        neovide_cursor_animation_length = 0.04,
        neovide_transparency = 0.9
    })
end

for key, value in pairs(global_opts) do vim.g[key] = value end

-- TODO: write this in lua
-- vim.cmd [[
--     let g:firenvim_config = {
--         \ 'globalSettings': {
--             \ 'alt': 'all',
--         \  },
--         \ 'localSettings': {
--             \ '.*': {
--                 \ 'selector': 'textarea',
--             \ },
--         \ }
--     \ }
-- ]]
