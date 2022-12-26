local null_ls = require("null-ls")

local code_actions = {
    null_ls.builtins.code_actions.gitsigns, null_ls.builtins.code_actions.shellcheck
}
local formatters = {
    null_ls.builtins.formatting.black, null_ls.builtins.formatting.isort,
    null_ls.builtins.formatting.lua_format
}
local diagnostics = {
    null_ls.builtins.diagnostics.mypy, null_ls.builtins.diagnostics.flake8,
    null_ls.builtins.diagnostics.rstcheck,
    null_ls.builtins.diagnostics.sqlfluff.with({extra_args = {"--dialect", "snowflake"}}),
    null_ls.builtins.formatting.sqlfluff.with({extra_args = {"--dialect", "snowflake"}}),
    null_ls.builtins.diagnostics.todo_comments
}
local hovers = {null_ls.builtins.hover.printenv}
local sources = {unpack(code_actions), unpack(formatters), unpack(diagnostics), unpack(hovers)}

null_ls.setup({sources = sources})
