return {
    'mbbill/undotree',
    lazy = true,
    keys = {
        {
            "<leader>u",
            function()
                if vim.o.modifiable or vim.bo.filetype == "undotree" then
                    return "<cmd>UndotreeToggle<CR>"
                else
                    return ""
                end
            end,
            desc = "toggle undotree",
            expr = true
        }
    }
}
