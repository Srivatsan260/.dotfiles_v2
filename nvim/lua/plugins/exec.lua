return {
    {
        'CRAG666/code_runner.nvim',
        opts = {
            mode = 'term',
            focus = true,
            border = 'single',
            filetype = {
                python = "python -u",
                rust = "cargo build && cargo run"
            }
        },
        keys = {
            {"<leader>x", "<cmd>RunFile<CR>", desc = "run current file using coderunner"},
        },
        lazy = true,
    },
    {
        'vim-test/vim-test',
        keys = {
            {"<leader>tsn", "<cmd>TestNearest<CR>", desc = "test nearest"},
            {"<leader>tsc", "<cmd>TestClass<CR>", desc = "test class"},
            {"<leader>tsf", "<cmd>TestFile<CR>", desc = "test file"},
        },
        lazy = true,
    },
}
