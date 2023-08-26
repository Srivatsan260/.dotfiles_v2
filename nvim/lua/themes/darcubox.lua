local M = {}

local theme_opts = {
    options = {
        transparent = true,
        styles = {
            comments = {},
            functions = {},
            keywords = {},
            types = {},
        },
    },
}

M.setup = function()
    require("darcubox").setup(theme_opts)
    vim.cmd.colorscheme("darcubox")
end

return M
