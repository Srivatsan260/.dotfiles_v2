local vimux_run_cmd = require("utils").vimux_run_cmd

return {
    {
        "CRAG666/code_runner.nvim",
        dependencies = { "preservim/vimux" },
        opts = {
            mode = "term",
            focus = true,
            border = "single",
            filetype = {
                python = "python -u",
                rust = vimux_run_cmd("cargo build && cargo run"),
                go = vimux_run_cmd("go run ."),
                terraform = vimux_run_cmd(
                    "terraform",
                    "terraform action:",
                    { "init", "apply", "destroy", "plan", "show", "validate" }
                ),
                scala = vimux_run_cmd("sbt", "sbt action:", { "run", "test" }),
            },
        },
        keys = {
            { "<leader>x", "<cmd>RunFile<CR>", desc = "run current file using coderunner" },
        },
        cmd = { "RunFile" },
        lazy = true,
    },
    {
        "vim-test/vim-test",
        dependencies = { "vim-floaterm" },
        keys = {
            { "<leader>tsn", "<cmd>TestNearest<CR>", desc = "test nearest" },
            { "<leader>tsc", "<cmd>TestClass<CR>", desc = "test class" },
            { "<leader>tsf", "<cmd>TestFile<CR>", desc = "test file" },
        },
        cmd = { "TestNearest", "TestFile", "TestClass" },
        lazy = true,
        config = function()
            vim.g["test#strategy"] = "floaterm"
        end,
    },
    {
        "skywind3000/asyncrun.vim",
        cmd = "AsyncRun",
    },
    -- {
    --     'luk400/vim-jukit',
    --     ft = {"json", "python"},
    --     init = function ()
    --         vim.g.jukit_ipython = 0
    --     end,
    --     config = function ()
    --         -- vim.g.jukit_terminal = "tmux"
    --     end,
    --     keys = {
    --         -- TODO add more keymaps here
    --         {"<leader>np", "<cmd>call jukit#convert#notebook_convert('jupyter-notebook')<cr>"},
    --         -- {"<leader>ht", "<cmd>call jukit#convert#save_nb_to_file(0,1,'html')<cr>"},
    --         -- {"<leader>rht", "<cmd>call jukit#convert#save_nb_to_file(1,1,'html')<cr>"},
    --         -- {"<leader>pd", "<cmd>call jukit#convert#save_nb_to_file(0,1,'pdf')<cr>"},
    --         -- {"<leader>rpd", "<cmd>call jukit#convert#save_nb_to_file(1,1,'pdf')<cr>"},
    --     }
    -- }
}
