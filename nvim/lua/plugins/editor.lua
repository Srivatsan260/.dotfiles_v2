return {
    {
        'gpanders/editorconfig.nvim',
        cond = function ()
            return vim.fn.glob(".editorconfig") ~= ""
        end,
    },
    {
        'airblade/vim-rooter',
        event = "VeryLazy",
    },
}
