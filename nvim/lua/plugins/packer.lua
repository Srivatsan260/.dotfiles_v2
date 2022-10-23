vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use 'folke/tokyonight.nvim'
    use 'ellisonleao/gruvbox.nvim'
    use 'ful1e5/onedark.nvim'
    use 'kyazdani42/nvim-web-devicons'
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use { 'nvim-treesitter/nvim-treesitter-context', run = ':TSUpdate' }
    use { 'nvim-treesitter/nvim-treesitter-refactor', run = ':TSUpdate' }
    use { 'nvim-treesitter/playground', run = ':TSUpdate' }
    use { 'kdheepak/lazygit.nvim' }
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'JoseConseco/telescope_sessions_picker.nvim'
        },
    }
    use {
        'princejoogie/dir-telescope.nvim',
        requires = { 'nvim-telescope/telescope.nvim' }
    }
    use 'voldikss/vim-floaterm'

    -- lsp
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
    use 'hrsh7th/cmp-path' -- nvim-cmp source for filesystem paths
    use 'hrsh7th/cmp-buffer' -- nvim-cmp source for buffer words
    use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
    use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
    use 'L3MON4D3/LuaSnip' -- Snippets plugin

    -- rust
    use 'simrat39/rust-tools.nvim'
    -- Debugging
    use 'nvim-lua/plenary.nvim'
    use 'mfussenegger/nvim-dap'
    use 'rcarriga/nvim-dap-ui'

    use 'kyazdani42/nvim-tree.lua'
    use 'airblade/vim-rooter'
    use 'junegunn/fzf.vim'
    use 'junegunn/fzf'
    use {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("trouble").setup {}
      end
    }
    use { 'EdenEast/nightfox.nvim',
        config = function()
            require('nightfox').setup {
                options = {
                    transparent = true,
                }
            }
        end
    }
    use {
      'lewis6991/gitsigns.nvim',
      config = function()
        require('gitsigns').setup()
      end
    }
    use 'JoseConseco/telescope_sessions_picker.nvim'
    use 'mbbill/undotree'
    use { 'numToStr/Comment.nvim' }
    use 'kristijanhusak/vim-dadbod-ui'
    use 'tpope/vim-dadbod'
    use 'kristijanhusak/vim-dadbod-completion'
    use 'ThePrimeagen/vim-be-good'
    use 'lewis6991/impatient.nvim'
    use 'ThePrimeagen/harpoon'
    use 'rhysd/git-messenger.vim'
end)
