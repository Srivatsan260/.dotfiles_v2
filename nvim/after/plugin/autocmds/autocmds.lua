local cursor_line_control = vim.api.nvim_create_augroup("CursorLineControl", {clear = true})
local set_cursorline = function(event, value, pattern)
    vim.api.nvim_create_autocmd(event, {
        group = cursor_line_control,
        pattern = pattern,
        callback = function()
            vim.opt_local.cursorline = value
        end
    })
end

set_cursorline("WinLeave", false)
set_cursorline("WinEnter", true)
set_cursorline("BufLeave", false)
set_cursorline("BufEnter", true)
set_cursorline("FileType", false, "TelescopePrompt")

local fold_control = vim.api.nvim_create_augroup("FoldControl", {clear = true})
vim.api.nvim_create_autocmd({"BufRead"}, {
    group = fold_control,
    pattern = "*",
    callback = function()
        vim.api.nvim_exec('normal zx zR', false)
    end
})
local highlight_yank = vim.api.nvim_create_augroup("HighlightYank", {clear = true})
vim.api.nvim_create_autocmd({"TextYankPost"}, {
    group = highlight_yank,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({higroup = 'Visual', timeout = 50})
    end
})
vim.api.nvim_create_autocmd({"VimResized"}, {
    pattern = "*",
    callback = function()
        vim.cmd.wincmd("=")
    end
})

vim.api.nvim_create_autocmd({"BufEnter", "WinEnter"}, {
    pattern = "*",
    callback = function()
        if vim.bo.filetype ~= "floaterm" then
            vim.cmd.normal("zz")
        end
    end
})

local filetype_control = vim.api.nvim_create_augroup("FileTypeControl", {clear = true})
vim.api.nvim_create_autocmd({"BufRead"}, {
    group = filetype_control,
    pattern = {"*shrc", "*sh"},
    callback = function()
        vim.bo.filetype = "sh"
    end
})

vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function ()
        local hl_groups = {
            "CursorLineNr",
            "Folded",
            "DiagnosticVirtualTextError",
            "DiagnosticVirtualTextWarn",
            "DiagnosticVirtualTextInfo",
            "DiagnosticVirtualTextHint",
            "TroubleNormal",
            "Tabline",
            "TablineFill"
        }
        for _, hl in pairs(hl_groups) do
            vim.cmd.highlight(hl .. " ctermbg=none guibg=none")
        end
    end
})
