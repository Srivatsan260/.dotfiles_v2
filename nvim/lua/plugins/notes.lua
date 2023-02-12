return {
    {
        'vimwiki/vimwiki',
        lazy = true,
        keys = "<leader>w",
        config = function ()
            local g_opts = {
                vimwiki_global_ext = 0,
                vimwiki_list = {{path = '~/.vimwiki/'}}
            }
            for k, v in pairs(g_opts) do
                vim.g[k] = v
            end
        end
    },
}
