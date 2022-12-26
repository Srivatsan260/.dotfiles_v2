local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.code_actions.gitsigns,
        null_ls.builtins.code_actions.shellcheck,
        null_ls.builtins.diagnostics.mypy,
        null_ls.builtins.diagnostics.flake8,
        null_ls.builtins.diagnostics.rstcheck,
        null_ls.builtins.diagnostics.sqlfluff.with({
            extra_args = { "--dialect", "snowflake" },
        }),
        null_ls.builtins.diagnostics.todo_comments,
    },
})