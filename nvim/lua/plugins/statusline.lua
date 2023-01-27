return {
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {'kyazdani42/nvim-web-devicons', lazy = true}
    },
    {
        'luukvbaal/statuscol.nvim',
    },
    {
        'jcdickinson/wpm.nvim',
        config = function ()
            require('wpm').setup()
        end
    }
}
