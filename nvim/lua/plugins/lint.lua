require('lint').linters_by_ft = {
    python = {'mypy', 'flake8'},
    sh = {'shellcheck'},
    lua = {'luacheck'}
}

local group = vim.api.nvim_create_augroup("LintGroup", {clear = true})
vim.api.nvim_create_autocmd({"BufEnter", "BufWritePost"}, {
    group = group,
    pattern = { "*.py", "*.sh", "*.lua" },
    callback = function() require("lint").try_lint() end
})
