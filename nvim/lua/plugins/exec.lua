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
            {"<leader><leader><leader>", "<cmd>RunFile<CR>", desc = "run current file using coderunner"},
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
        config = function ()
            vim.g['test#strategy'] = 'floaterm'
        end
    },
    {
        'skywind3000/asyncrun.vim',
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
