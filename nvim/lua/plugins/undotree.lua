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
    },
    init = function ()
        local g_opts = {
            undotree_SetFocusWhenToggle = 1
        }
        for k, v in pairs(g_opts) do
            vim.g[k] = v
        end
    end
}
