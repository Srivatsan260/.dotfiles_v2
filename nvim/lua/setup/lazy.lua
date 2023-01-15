local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

return require('lazy').setup({
    'nvim-lua/plenary.nvim',

    -- themes
    'folke/tokyonight.nvim',
    'ellisonleao/gruvbox.nvim',
    'navarasu/onedark.nvim',
    {'rose-pine/neovim', name = 'rose-pine'},
    'rebelot/kanagawa.nvim',
    'catppuccin/nvim',

    -- icons
    'kyazdani42/nvim-web-devicons',

    -- statusline
    {'nvim-lualine/lualine.nvim', dependencies = {'kyazdani42/nvim-web-devicons', lazy = true}},

    -- treesitter
    {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
    {'nvim-treesitter/nvim-treesitter-context', build = ':TSUpdate'},
    {'nvim-treesitter/nvim-treesitter-textobjects', build = ':TSUpdate'},
    {'nvim-treesitter/playground', build = ':TSUpdate'},
    'ckolkey/ts-node-action',

    -- autogenerate docstrings
    'danymat/neogen',

    -- lazygit
    'kdheepak/lazygit.nvim',

    -- fugitive
    'tpope/vim-fugitive',
    'tommcdo/vim-fubitive',
    'tpope/vim-rhubarb',

    -- diffview
    'sindrets/diffview.nvim',

    -- telescope
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {'nvim-lua/plenary.nvim', 'JoseConseco/telescope_sessions_picker.nvim'}
    },
    {'princejoogie/dir-telescope.nvim', dependencies = {'nvim-telescope/telescope.nvim'}},
    {'jvgrootveld/telescope-zoxide', dependencies = {'nvim-lua/popup.nvim'}},
    'nvim-telescope/telescope-file-browser.nvim',
    'JoseConseco/telescope_sessions_picker.nvim',

    -- floating terminal
    'voldikss/vim-floaterm',
    'voldikss/fzf-floaterm',

    -- lsp
    'jose-elias-alvarez/null-ls.nvim',
    'VonHeikemen/lsp-zero.nvim',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
    'hrsh7th/nvim-cmp', -- Autocompletion plugin
    'hrsh7th/cmp-path', -- nvim-cmp source for filesystem paths
    'hrsh7th/cmp-buffer', -- nvim-cmp source for buffer words
    'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
    'hrsh7th/cmp-nvim-lua', -- LSP source for nvim-cmp
    'saadparwaiz1/cmp_luasnip', -- Snippets source for nvim-cmp
    'L3MON4D3/LuaSnip', -- Snippets plugin
    'folke/neodev.nvim',
    'rafamadriz/friendly-snippets',
    'ray-x/lsp_signature.nvim',
    'j-hui/fidget.nvim',
    -- rust
    'simrat39/rust-tools.nvim',
    'saecki/crates.nvim',

    -- Debugging
    'mfussenegger/nvim-dap',
    'rcarriga/nvim-dap-ui',

    -- project tree explorer
    'kyazdani42/nvim-tree.lua',

    -- make vim change rootdir as expected
    'airblade/vim-rooter',

    -- fzf
    'junegunn/fzf.vim',
    'junegunn/fzf',

    -- display errors / warnings
    {"folke/trouble.nvim", dependencies = "kyazdani42/nvim-web-devicons"},
    'folke/todo-comments.nvim',

    -- show git diffs in signcolumn
    'lewis6991/gitsigns.nvim',

    -- undo superpowers
    'mbbill/undotree',

    -- comments
    'numToStr/Comment.nvim',

    -- sql
    'kristijanhusak/vim-dadbod-ui',
    'tpope/vim-dadbod',
    'kristijanhusak/vim-dadbod-completion',

    -- vim tut
    'ThePrimeagen/vim-be-good',

    -- harpoon!
    'ThePrimeagen/harpoon',

    -- git blame but more
    'rhysd/git-messenger.vim',

    -- notetaking
    'vimwiki/vimwiki',

    -- interactive code evaluation
    'Olical/conjure',
    'PaterJason/cmp-conjure',

    -- nvim-surround
    { "kylechui/nvim-surround", version = "*"},

    -- more textobjects!
    'chrisgrieser/nvim-various-textobjs',

    -- nvim-colorizer
    'norcalli/nvim-colorizer.lua',

    -- rest client
    'rest-nvim/rest.nvim',

    -- which-key
    'folke/which-key.nvim',

    -- tests
    'vim-test/vim-test',

    -- async run
    'skywind3000/asyncrun.vim',

    -- git-worktree
    'ThePrimeagen/git-worktree.nvim',

    -- lua-formatter
    'andrejlevkovitch/vim-lua-format',

    -- dressing
    'stevearc/dressing.nvim',

    -- autopairs
    'windwp/nvim-autopairs',

    -- icon picker
    'ziontee113/icon-picker.nvim',

    -- symbols-outline
    'simrat39/symbols-outline.nvim',

    -- carbon.sh
    'ellisonleao/carbon-now.nvim',

    -- colorutils
    'nvim-colortils/colortils.nvim',

    -- xterm-colors
    'guns/xterm-color-table.vim',

    'MunifTanjim/nui.nvim',

    -- cellular automaton
    'Eandrju/cellular-automaton.nvim',

    -- coderunner
    'CRAG666/code_runner.nvim',

    -- quickfix nav / edit
    {'kevinhwang91/nvim-bqf', ft = "qf"},

    -- editorconfig
    'gpanders/editorconfig.nvim',

    -- tmux integration
    'aserowy/tmux.nvim',

    -- speeddating
    'tpope/vim-speeddating',

    -- convert numbers between base 2, 8, 10, 16
    {'glts/vim-radical', dependencies = {'glts/vim-magnum'}},

    -- UNIX ops
    'tpope/vim-eunuch',
})
