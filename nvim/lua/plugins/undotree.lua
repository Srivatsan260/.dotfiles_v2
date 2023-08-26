return {
    "mbbill/undotree",
    lazy = true,
    keys = {
        {
            "<leader>u",
            function()
                local excluded_fts = {
                    "netrw",
                    "harpoon",
                    "fugitive",
                    -- TODO add more here
                }
                for _, ft in ipairs(excluded_fts) do
                    if vim.bo.filetype == ft then
                        return ""
                    end
                end
                if
                    vim.o.modifiable
                    or vim.bo.filetype == "undotree"
                    or vim.bo.filetype == "diff"
                then
                    return "<cmd>UndotreeToggle<CR>"
                else
                    return ""
                end
            end,
            desc = "toggle undotree",
            expr = true,
        },
    },
    init = function()
        local g_opts = {
            undotree_SetFocusWhenToggle = 1,
        }
        for k, v in pairs(g_opts) do
            vim.g[k] = v
        end
    end,
}
