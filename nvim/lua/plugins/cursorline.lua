-- TODO: figure out how to move this to functions.lua
local group = vim.api.nvim_create_augroup("CursorLineControl", { clear = true })
local set_cursorline = function(event, value, pattern)
    vim.api.nvim_create_autocmd(event, {
        group = group,
        pattern = pattern,
        callback = function()
            vim.opt_local.cursorline = value
        end,
    })
end

set_cursorline("WinLeave", false)
set_cursorline("WinEnter", true)
set_cursorline("BufLeave", false)
set_cursorline("BufEnter", true)
set_cursorline("FileType", false, "TelescopePrompt")