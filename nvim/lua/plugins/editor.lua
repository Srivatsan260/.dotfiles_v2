return {
    {
        "gpanders/editorconfig.nvim",
        cond = function()
            return vim.fn.glob(".editorconfig") ~= ""
        end,
    },
    {
        "airblade/vim-rooter",
        event = "VeryLazy",
    },
    {
        "kiran94/s3edit.nvim",
        config = true,
        cmd = "S3Edit",
    },
}
