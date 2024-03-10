return {
    "shaunsingh/moonlight.nvim",
    name = "moonlight",
    event = "ColorSchemePre",
    init = function()
        vim.g.moonlight_italic_comments = false
        vim.g.moonlight_italic_keywords = false
        vim.g.moonlight_italic_functions = false
        vim.g.moonlight_italic_variables = false
        vim.g.moonlight_contrast = false
        vim.g.moonlight_borders = true
        vim.g.moonlight_disable_background = true
    end,
}
