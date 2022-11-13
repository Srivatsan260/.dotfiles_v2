vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use 'nvim-lua/plenary.nvim'

    -- themes
    use 'folke/tokyonight.nvim'
    use 'ellisonleao/gruvbox.nvim'
    use 'navarasu/onedark.nvim'
    use {
        'EdenEast/nightfox.nvim',
        config = function()
            require('nightfox').setup {options = {transparent = true}}
        end
    }

    -- icons
    use 'kyazdani42/nvim-web-devicons'

    -- statusline
    use {
        'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }

    -- treesitter
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use {'nvim-treesitter/nvim-treesitter-context', run = ':TSUpdate'}
    use {'nvim-treesitter/nvim-treesitter-refactor', run = ':TSUpdate'}
    use {'nvim-treesitter/nvim-treesitter-textobjects', run = ':TSUpdate'}
    use {'nvim-treesitter/playground', run = ':TSUpdate'}

    -- lazygit
    use {'kdheepak/lazygit.nvim'}

    -- telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'JoseConseco/telescope_sessions_picker.nvim'
        }
    }
    use {
        'princejoogie/dir-telescope.nvim',
        requires = {'nvim-telescope/telescope.nvim'}
    }

    -- floating terminal
    use 'voldikss/vim-floaterm'

    -- lsp
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
    use 'hrsh7th/cmp-path' -- nvim-cmp source for filesystem paths
    use 'hrsh7th/cmp-buffer' -- nvim-cmp source for buffer words
    use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
    use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
    use 'L3MON4D3/LuaSnip' -- Snippets plugin
    use 'folke/neodev.nvim'
    use {
        'ray-x/lsp_signature.nvim',
        config = function() require('lsp_signature').setup() end
    }
    use {
        'j-hui/fidget.nvim',
        config = function() require('fidget').setup {} end
    }
    -- rust
    use 'simrat39/rust-tools.nvim'

    -- Debugging
    use 'mfussenegger/nvim-dap'
    use 'rcarriga/nvim-dap-ui'

    -- project tree explorer
    use 'kyazdani42/nvim-tree.lua'

    -- make vim change rootdir as expected
    use 'airblade/vim-rooter'

    -- fzf
    use 'junegunn/fzf.vim'
    use 'junegunn/fzf'

    -- display errors / warnings
    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function() require("trouble").setup {} end
    }

    -- show git diffs in signcolumn
    use {
        'lewis6991/gitsigns.nvim',
        config = function() require('gitsigns').setup() end
    }

    use 'JoseConseco/telescope_sessions_picker.nvim'

    -- undo superpowers
    use 'mbbill/undotree'

    -- comments
    use {'numToStr/Comment.nvim'}

    -- sql
    use 'kristijanhusak/vim-dadbod-ui'
    use 'tpope/vim-dadbod'
    use 'kristijanhusak/vim-dadbod-completion'

    -- vim tut
    use 'ThePrimeagen/vim-be-good'

    -- cache nvim modules
    use 'lewis6991/impatient.nvim'

    -- harpoon!
    use 'ThePrimeagen/harpoon'

    -- git blame but more
    use 'rhysd/git-messenger.vim'

    -- notetaking
    use 'vimwiki/vimwiki'

    -- interactive code evaluation
    use 'Olical/conjure'
    use 'PaterJason/cmp-conjure'

    -- nvim-surround
    use {
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    }
    -- indent textobject
    use 'michaeljsmith/vim-indent-object'

    -- nvim-colorizer
    use 'norcalli/nvim-colorizer.lua'

    -- rest client
    use 'rest-nvim/rest.nvim'

    -- which-key
    use 'folke/which-key.nvim'

    -- tests
    use 'vim-test/vim-test'

    -- async run
    use 'skywind3000/asyncrun.vim'

    -- sad
    use 'ray-x/sad.nvim'
    use 'ray-x/guihua.lua'

    -- git-worktree
    use 'ThePrimeagen/git-worktree.nvim'

    -- lua-formatter
    use 'andrejlevkovitch/vim-lua-format'

    -- structural find & replace
    use {
        "cshuaimin/ssr.nvim",
        module = "ssr",
    }
end)
