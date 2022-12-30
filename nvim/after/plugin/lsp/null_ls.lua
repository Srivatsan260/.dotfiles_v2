local null_ok, null_ls = pcall(require, "null-ls")
if not null_ok then return end

local sources = {
    -- code actions
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.code_actions.shellcheck,
    -- formatters
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.isort,
    null_ls.builtins.formatting.lua_format,
    null_ls.builtins.formatting.sqlfluff.with({extra_args = {"--dialect", "snowflake"}}),
    -- diagnostics
    null_ls.builtins.diagnostics.mypy, null_ls.builtins.diagnostics.flake8,
    null_ls.builtins.diagnostics.rstcheck,
    null_ls.builtins.diagnostics.sqlfluff.with({extra_args = {"--dialect", "snowflake"}}),
    -- hovers
    null_ls.builtins.hover.printenv
}

null_ls.setup({sources = sources})
