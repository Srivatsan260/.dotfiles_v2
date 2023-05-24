return {
    {
        'CRAG666/code_runner.nvim',
        opts = {
            mode = 'term',
            focus = true,
            border = 'single',
            filetype = {
                python = "python -u",
                rust = "cargo build && cargo run",
                go = "go run .",
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
        'luk400/vim-jukit',
        ft = {"json", "python"},
        keys = {
            -- TODO add more keymaps here
            {"<leader>np", "<cmd>call jukit#convert#notebook_convert('jupyter-notebook')<cr>"},
            -- {"<leader>ht", "<cmd>call jukit#convert#save_nb_to_file(0,1,'html')<cr>"},
            -- {"<leader>rht", "<cmd>call jukit#convert#save_nb_to_file(1,1,'html')<cr>"},
            -- {"<leader>pd", "<cmd>call jukit#convert#save_nb_to_file(0,1,'pdf')<cr>"},
            -- {"<leader>rpd", "<cmd>call jukit#convert#save_nb_to_file(1,1,'pdf')<cr>"},
        }
    }
}
