local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.code_actions.gitsigns,
        null_ls.builtins.code_actions.shellcheck,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.lua_format,
        null_ls.builtins.diagnostics.mypy,
        null_ls.builtins.diagnostics.flake8,
        null_ls.builtins.diagnostics.rstcheck,
        null_ls.builtins.diagnostics.sqlfluff.with({
            extra_args = { "--dialect", "snowflake" },
        }),
        null_ls.builtins.formatting.sqlfluff.with({
            extra_args = { "--dialect", "snowflake" },
        }),
        null_ls.builtins.diagnostics.todo_comments,
        null_ls.builtins.hover.printenv,
    },
})
