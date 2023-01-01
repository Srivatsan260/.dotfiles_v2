local M = {}

local theme_opts = {
    undercurl = true, -- enable undercurls
    commentStyle = {italic = true},
    functionStyle = {},
    keywordStyle = {italic = true},
    statementStyle = {bold = true},
    typeStyle = {},
    variablebuiltinStyle = {italic = true},
    specialReturn = true, -- special highlight for the return keyword
    specialException = true, -- special highlight for exception handling keywords
    transparent = true, -- do not set background color
    dimInactive = false, -- dim inactive window `:h hl-NormalNC`
    globalStatus = false, -- adjust window separators highlight for laststatus=3
    terminalColors = true, -- define vim.g.terminal_color_{0,17}
    colors = {},
    overrides = {},
    theme = "default" -- Load "default" theme or the experimental "light" theme
}

M.setup = function ()
    require("kanagawa").setup(theme_opts)
    vim.cmd.colorscheme("kanagawa")
end

M.lualine_colors = {
    black = "#000000",
    default = "#7E9CDB",
    innerbg = nil,
    outerbg = nil,
    normal = "#7E9CDB",
    insert = "#08EE50",
    visual = "#FF90C9",
    replace = "#E46876",
    command = "#FFC07A",
    terminal = '#00FFFF'
}

return M
