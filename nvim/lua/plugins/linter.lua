return {
    "mfussenegger/nvim-lint",
    ft = { "python", "sh", "lua", "sql" },
    config = function()
        local lint = require("lint")
        lint.linters_by_ft = {
            -- python = { "mypy", "flake8" },
            sh = { "shellcheck" },
            lua = { "luacheck" },
            sql = { "sqlfluff" },
        }

        local luacheck = lint.linters.luacheck
        luacheck.args = { "--globals", "vim" }

        local sqlfluff = lint.linters.sqlfluff
        sqlfluff.args = { "lint", "--format=json", "--dialect=snowflake" }
        local group = vim.api.nvim_create_augroup("LintGroup", { clear = true })
        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
            group = group,
            pattern = { "*.sh", "*.lua", "*.sql" },
            callback = function()
                lint.try_lint()
            end,
        })
    end,
}
