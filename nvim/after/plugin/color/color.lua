local theme = "themes." .. vim.g.global_colorscheme
local ok, theme_mod = pcall(require, theme)
if ok then
    theme_mod.setup()
    vim.cmd("colorscheme " .. vim.g.global_colorscheme)
end
