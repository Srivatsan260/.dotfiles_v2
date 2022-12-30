-- luasnip setup
local luasnip_ok, luasnip = pcall(require, "luasnip")
if luasnip_ok then
    luasnip.config.set_config {
        history = true,
        updateevents = "TextChanged,TextChangedI",
        enable_autosnippets = true
    }
    require("luasnip.loaders.from_vscode").lazy_load()
end

-- nvim-cmp setup
local cmp_ok, cmp = pcall(require, "cmp")
if cmp_ok then
    cmp.setup {
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-/>'] = cmp.mapping(cmp.mapping.complete({reason = cmp.ContextReason.Auto}), {"i", "c"}),
            ['<CR>'] = cmp.mapping.confirm {behavior = cmp.ConfirmBehavior.Replace, select = true},
            ['<C-k>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end, {'i', 's'}),
            ['<C-j>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, {'i', 's'})
        }),
        sources = {
            {name = 'nvim_lsp'}, {name = 'nvim_lua'}, {name = 'luasnip'}, {name = 'buffer'},
            {name = 'path'}, {name = 'vim-dadbod-completion'}, {name = 'conjure'}, {name = 'crates'}
        }
    }
end
