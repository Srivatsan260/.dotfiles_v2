return {
    "gpanders/editorconfig.nvim",
    enabled = false,
    cond = function()
        return vim.fn.glob(".editorconfig") ~= ""
    end,
}
