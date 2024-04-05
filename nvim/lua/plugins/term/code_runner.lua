-- TODO: Do I really need this plugin?
local vimux_run_cmd = require("utils").vimux_run_cmd

return {
    "CRAG666/code_runner.nvim",
    enabled = false,
    dependencies = { "preservim/vimux" },
    opts = {
        mode = "term",
        focus = true,
        border = "single",
        filetype = {
            -- TODO: Fix python filetype
            python = "python -u",
            rust = vimux_run_cmd("cargo build && cargo run"),
            go = vimux_run_cmd("go run ."),
            terraform = vimux_run_cmd(
                "terraform",
                "terraform action:",
                { "init", "apply", "destroy", "plan", "show", "validate" }
            ),
            scala = vimux_run_cmd("sbt", "sbt action:", { "run", "test" }),
            ocaml = vimux_run_cmd("dune exec", "enter executable")
        },
    },
    keys = {
        { "<leader>x", "<cmd>RunFile<CR>", desc = "run current file using coderunner" },
    },
    cmd = { "RunFile" },
    lazy = true,
}
