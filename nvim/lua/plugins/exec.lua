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
        cmd = {"RunFile"},
        lazy = true,
    },
    {
        'vim-test/vim-test',
        dependencies = {"vim-floaterm"},
        keys = {
            {"<leader>tsn", "<cmd>TestNearest<CR>", desc = "test nearest"},
            {"<leader>tsc", "<cmd>TestClass<CR>", desc = "test class"},
            {"<leader>tsf", "<cmd>TestFile<CR>", desc = "test file"},
        },
        cmd = {"TestNearest", "TestFile", "TestClass"},
        lazy = true,
        config = function ()
            vim.g['test#strategy'] = 'floaterm'
        end
    },
    {
        'skywind3000/asyncrun.vim',
        cmd = "AsyncRun",
    },
    {
        'Olical/conjure',
        dependencies = 'PaterJason/cmp-conjure',
        ft = "python",
        config = function ()
            vim.g['conjure#client_on_load'] = false
        end
    }
}
