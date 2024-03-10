return {
    "gpanders/editorconfig.nvim",
    cond = function()
        return vim.fn.glob(".editorconfig") ~= ""
    end,
}
