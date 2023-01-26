return {
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {'nvim-lua/plenary.nvim', 'JoseConseco/telescope_sessions_picker.nvim'}
    },
    {'princejoogie/dir-telescope.nvim', dependencies = {'nvim-telescope/telescope.nvim'}},
    {'jvgrootveld/telescope-zoxide', dependencies = {'nvim-lua/popup.nvim'}},
    'nvim-telescope/telescope-file-browser.nvim',
    'JoseConseco/telescope_sessions_picker.nvim',
    {'nvim-telescope/telescope-frecency.nvim', dependencies = {'kkharji/sqlite.lua'}},
}
