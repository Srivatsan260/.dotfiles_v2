local opt = vim.opt
local g = vim.g

opt.background = "dark"
opt.backup = false
opt.belloff = "all"
opt.cmdheight = 1
opt.colorcolumn = "100"
opt.completeopt = { "menuone", "noselect" }
opt.conceallevel = 0
opt.expandtab = true
opt.exrc = true
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldmethod = "expr"
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep --no-heading --smart-case"
opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"
opt.hlsearch = false
opt.ignorecase = true
opt.inccommand = "split"
opt.incsearch = true
opt.laststatus = 3
opt.list = true
opt.listchars = { eol = "﬋", tab = "» ", nbsp = "␣", trail = "•" }
opt.mouse = "nvi"
opt.nu = true
opt.rnu = true
opt.scrolloff = 8
opt.shada = { "!", "'1000", "<50", "s10", "h" }
opt.shiftwidth = 4
opt.showbreak = "↪"
opt.showmatch = true
opt.showmode = false
opt.signcolumn = "yes"
opt.smartcase = true
opt.smartindent = true
opt.softtabstop = 4
opt.splitright = true
opt.swapfile = false
opt.tabstop = 4
opt.termguicolors = true
opt.timeoutlen = 250
opt.undofile = true
opt.updatetime = 250
opt.winbar = "%f %m"
opt.wrap = false
if vim.fn.has("nvim-0.9.0") == 1 then
    opt.splitkeep = "screen"
end

opt.formatoptions = opt.formatoptions
    - "a" -- Auto formatting is BAD.
    - "t" -- Don't auto format my code. I got linters for that.
    + "c" -- When comments respect textwidth
    + "q" -- Allow formatting comments w/ gq
    - "o" -- O and o, don't continue comments
    + "r" -- But do continue when pressing enter.
    + "n" -- Indent past the formatlistpat, not underneath it.
    + "j" -- Auto-remove comments if possible.
    - "2" -- Don't use indent of 2nd line of paragraph for the rest of it

g.global_colorscheme = "tokyonight"
g.mapleader = " "
g.maplocalleader = "\\"
g.netrw_altv = 1
g.netrw_banner = 0
g.netrw_browse_split = 0
g.netrw_bufsettings = "noma nomod nu nobl nowrap ro"
g.netrw_winsize = 75
g.sessions_dir = "~/.local/share/nvim/session"

if g.neovide then
    g.neovide_cursor_trail_length = 0.8
    g.neovide_cursor_animation_length = 0.04
    g.neovide_transparency = 0.9
end
