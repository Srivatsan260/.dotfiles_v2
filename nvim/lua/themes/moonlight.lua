local M = {}

M.setup = function()
    vim.g.moonlight_italic_comments = false
    vim.g.moonlight_italic_keywords = false
    vim.g.moonlight_italic_functions = false
    vim.g.moonlight_italic_variables = false
    vim.g.moonlight_contrast = false
    vim.g.moonlight_borders = true
    vim.g.moonlight_disable_background = true
    vim.cmd.colorscheme("moonlight")
end

return M
