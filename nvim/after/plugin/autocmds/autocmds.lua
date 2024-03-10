local cursor_line_control = vim.api.nvim_create_augroup("CursorLineControl", { clear = true })
local set_cursorline = function(event, value, pattern)
    vim.api.nvim_create_autocmd(event, {
        group = cursor_line_control,
        pattern = pattern,
        callback = function()
            vim.opt_local.cursorline = value
            -- vim.opt_local.cursorcolumn = value
        end,
    })
end

set_cursorline("WinLeave", false)
set_cursorline("WinEnter", true)
set_cursorline("BufLeave", false)
set_cursorline("BufEnter", true)
set_cursorline("FileType", false, "TelescopePrompt")

local fold_control = vim.api.nvim_create_augroup("FoldControl", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead" }, {
    group = fold_control,
    pattern = "*",
    callback = function()
        vim.cmd.normal("zx zR")
    end,
})
local highlight_yank = vim.api.nvim_create_augroup("HighlightYank", { clear = true })
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    group = highlight_yank,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higroup = "Visual", timeout = 75 })
    end,
})
vim.api.nvim_create_autocmd({ "VimResized" }, {
    pattern = "*",
    callback = function()
        vim.cmd.wincmd("=")
    end,
})

local filetype_control = vim.api.nvim_create_augroup("FileTypeControl", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead" }, {
    group = filetype_control,
    pattern = { "*shrc", "*sh" },
    callback = function()
        vim.bo.filetype = "sh"
    end,
})
vim.api.nvim_create_autocmd({ "BufRead" }, {
    group = filetype_control,
    pattern = { "*.tf" },
    callback = function()
        vim.bo.filetype = "terraform"
    end,
})

local ok, cloak = pcall(require, "cloak")
if ok then
    vim.api.nvim_create_autocmd(
        { "BufRead" },
        {
            pattern = { "*cfg", "*env", "config", "credentials" },
            callback = function ()
                cloak.enable()
            end
        }
    )
end

-- set colorscheme
vim.api.nvim_create_autocmd({ "VimEnter" }, {
    pattern = "*",
    callback = function()
        vim.cmd.colorscheme(vim.g.global_colorscheme)
    end,
})
