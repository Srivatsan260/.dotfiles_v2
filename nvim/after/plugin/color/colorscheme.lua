if vim.g.global_colorscheme == nil then
    return
end
local theme = "themes." .. vim.g.global_colorscheme
local ok, theme_mod = pcall(require, theme)
if ok then
    theme_mod.setup()
end
