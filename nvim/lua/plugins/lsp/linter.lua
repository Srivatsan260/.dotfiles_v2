return {
    "mfussenegger/nvim-lint",
    ft = { "python", "sh", "lua", "sql", "jinja" },
    config = function()
        local lint = require("lint")
        lint.linters_by_ft = {
            -- python = { "mypy", "flake8" },
            sh = { "shellcheck" },
            lua = { "luacheck" },
            sql = { "sqlfluff" },
            jinja = { "j2lint" },
            make = { "checkmake" },
        }

        local luacheck = lint.linters.luacheck
        luacheck.args = { "--globals", "vim" }

        local sqlfluff = lint.linters.sqlfluff
        sqlfluff.args = { "lint", "--format=json", "--dialect=snowflake" }

        lint.linters.j2lint = {
            cmd = "j2lint",
            name = "j2lint",
            stdin = true,
            append_fname = true,
            args = { "-s", "-j" },
            ignore_exitcode = true,
            parser = function(output)
                if output == nil then
                    return {}
                end

                local diagnostics = {}
                local json = vim.json.decode(output) or {}

                local insight_to_severity = {
                    ERRORS = vim.diagnostic.severity.ERROR,
                    WARNINGS = vim.diagnostic.severity.WARN,
                }

                for insight, severity in pairs(insight_to_severity) do
                    local results = json[insight]
                    for _, result in ipairs(results or {}) do
                        table.insert(diagnostics, {
                            lnum = result.line_number - 1,
                            col = 0,
                            message = result.message,
                            severity = severity,
                        })
                    end
                end

                return diagnostics
            end,
        }

        -- lint.linters.checkmake = {
        --     name = "checkmake",
        --     cmd = "checkmake",
        --     stdin = false,
        --     append_fname = true,
        --     args = {
        --         "--format='{{.LineNumber}}:{{.Violation}}\n'",
        --     },
        --     ignore_exitcode = true,
        --     parser = function(output)
        --         print(output)
        --         if output == nil then
        --             return {}
        --         end
        --         local diagnostics = {}
        --         for line in output:gmatch("[^\r\n]+") do
        --             local parts = vim.split(line, ":")
        --             print(parts)
        --             table.insert(diagnostics, {
        --                 lnum = tonumber(parts[1]),
        --                 col = 0,
        --                 message = parts[2],
        --                 severity = vim.diagnostic.severity.ERROR,
        --             })
        --         end
        --         return diagnostics
        --     end,
        -- }

        local group = vim.api.nvim_create_augroup("LintGroup", { clear = true })
        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
            group = group,
            pattern = { "*.sh", "*.lua", "*.sql", "*.jinja", "*Makefile" },
            callback = function()
                lint.try_lint()
            end,
        })
    end,
}
