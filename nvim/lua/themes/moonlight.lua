local M = {}

M.setup = function()
    vim.g.moonlight_italic_comments = true
    vim.g.moonlight_italic_keywords = true
    vim.g.moonlight_italic_functions = true
    vim.g.moonlight_italic_variables = true
    vim.g.moonlight_contrast = true
    vim.g.moonlight_borders = false
    vim.g.moonlight_disable_background = true
    vim.cmd.colorscheme("moonlight")
end

return M
