return {
    {
        'jose-elias-alvarez/null-ls.nvim',
        ft = {"python", "sql", "sh", "bash", "zsh", "lua"},
        config = function ()
            local null_ls = require("null-ls")
            local sources = {
                -- code actions
                null_ls.builtins.code_actions.gitsigns,
                null_ls.builtins.code_actions.shellcheck,
                -- formatters
                null_ls.builtins.formatting.black,
                null_ls.builtins.formatting.isort,
                null_ls.builtins.formatting.lua_format,
                null_ls.builtins.formatting.sqlfluff.with({extra_args = {"--dialect", "snowflake"}}),
                -- diagnostics
                null_ls.builtins.diagnostics.mypy, null_ls.builtins.diagnostics.flake8,
                null_ls.builtins.diagnostics.rstcheck,
                null_ls.builtins.diagnostics.sqlfluff.with({extra_args = {"--dialect", "snowflake"}}),
                -- hovers
                null_ls.builtins.hover.printenv
            }
            null_ls.setup({sources = sources})
        end
    },

    {
        'VonHeikemen/lsp-zero.nvim',
        event = {"BufReadPre", "BufNewFile"},
        dependencies = {
            {
                'neovim/nvim-lspconfig',
                dependencies = {'williamboman/mason.nvim'},
            },
            {'folke/neodev.nvim', config = function() require("neodev").setup() end},
            'ray-x/lsp_signature.nvim',
            'j-hui/fidget.nvim',
            'simrat39/symbols-outline.nvim',
            "folke/trouble.nvim"
        },
        config = function()
            local lsp = require("lsp-zero")
            lsp.preset('recommended')
            lsp.ensure_installed({'pyright', 'tsserver', 'html', 'cssls', 'emmet_ls', 'lua_ls'})
            lsp.set_preferences({
                set_lsp_keymaps = false,
                manage_nvim_cmp = false,
                sign_icons = {error = 'E', warn = 'W', hint = 'H', info = 'I'}
            })
            lsp.configure('lua_ls', {
                settings = {
                    Lua = {
                        workspace = {library = vim.api.nvim_get_runtime_file("", true)},
                        diagnostics = {globals = {'vim'}},
                        telemetry = {enable = false},
                        completion = {callSnippet = 'Replace'}
                    }
                }
            })
            lsp.on_attach(function(_, bufnr)
                vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

                local bufopts = function(desc)
                    return {noremap = true, silent = true, buffer = bufnr, desc = desc}
                end
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts("goto declaration"))
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts("goto definition"))
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts("help"))
                vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<CR>', bufopts("find lsp references"))
                vim.keymap.set('n', '<leader>g,', vim.lsp.buf.signature_help, bufopts("signature help"))
                vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, bufopts("goto implementation"))
                vim.keymap.set('n', '<leader>gt', vim.lsp.buf.type_definition, bufopts("goto type definition"))
                vim.keymap.set('n', '<leader>ds', vim.lsp.buf.document_symbol,
                bufopts("list document lsp symbols"))
                vim.keymap.set('n', '<leader>dS', vim.lsp.buf.workspace_symbol,
                bufopts("list workspace lsp symbols"))
                vim.keymap.set('n', '<leader>ac', vim.lsp.buf.code_action, bufopts("code actions"))
                vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts("rename current symbol"))
                -- if vim.bo.filetype == 'python' then
                --     vim.keymap.set('n', '<leader>-', '<cmd>!isort %<CR>', bufopts("isort"))
                if vim.bo.filetype == 'lua' then
                    vim.keymap.set('n', '<leader>=', '<cmd>call LuaFormat()<CR>', bufopts("luaformat"))
                else
                    vim.keymap.set('n', '<leader>=', vim.lsp.buf.format, bufopts("format document"))
                end
                vim.keymap.set('n', '<leader>ai', vim.lsp.buf.incoming_calls, bufopts("list incoming calls"))
                vim.keymap.set('n', '<leader>ao', vim.lsp.buf.outgoing_calls, bufopts("list outgoing calls"))
                vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder,
                bufopts("add workspace folder"))
                vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder,
                bufopts("remove workspace folder"))
                vim.keymap.set('n', '<leader>sc', function()
                    print(vim.inspect(vim.lsp.get_active_clients()[1].server_capabilities))
                end, bufopts("list lsp server capabilities"))
                vim.keymap.set('n', '<leader>wl', function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, bufopts("list workspace folders"))
            end)
            lsp.setup()

            vim.diagnostic.config({
                virtual_text = true,
                signs = true,
                update_in_insert = false,
                underline = true,
                severity_sort = true,
                float = true
            })
        end
    },

    {
        'williamboman/mason.nvim',
        dependencies = {'williamboman/mason-lspconfig.nvim'},
        keys = {
            {"<leader>M", "<cmd>Mason<CR>", desc = "open Mason"}
        },
        lazy = true,
    },

    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',
            'saadparwaiz1/cmp_luasnip',
            "L3MON4D3/LuaSnip",
            'rafamadriz/friendly-snippets'
        },
        event = "InsertEnter",
        config = function ()
            local luasnip_ok, luasnip = pcall(require, "luasnip")
            if not luasnip_ok then return end
            luasnip.config.set_config {
                history = true,
                updateevents = "TextChanged,TextChangedI",
                enable_autosnippets = true
            }
            local f_ok, friendly_snippets = pcall(require, "luasnip.loaders.from_vscode")
            if f_ok then friendly_snippets.lazy_load() end

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
                        ['<C-/>'] = cmp.mapping(cmp.mapping.complete({reason = cmp.ContextReason.Auto}),
                        {"i", "c"}),
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
        end
    },

    {
        'simrat39/rust-tools.nvim',
        ft = "rust",
        opts = {
            server = {
                on_attach = function(_, bufnr)
                    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
                    local bufopts = function(desc)
                        return {noremap = true, silent = true, buffer = bufnr, desc = desc}
                    end
                    vim.keymap.set('n', 'K', require("rust-tools").hover_actions.hover_actions, bufopts("hover actions"))
                    vim.keymap.set('n', '<leader>ac', require("rust-tools").code_action_group.code_action_group, bufopts(""))
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts("goto declaration"))
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts("goto definition"))
                    vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, bufopts("goto implementation"))
                    vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<CR>', bufopts("find lsp references"))
                    vim.keymap.set('n', 'g,', vim.lsp.buf.signature_help, bufopts("signature help"))
                    vim.keymap.set('n', '<leader>=', vim.lsp.buf.format, bufopts("format document"))
                    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts("rename symbol"))
                    vim.keymap.set('n', '<leader>ai', vim.lsp.buf.incoming_calls,
                    bufopts("list incoming calls"))
                    vim.keymap.set('n', '<leader>ao', vim.lsp.buf.outgoing_calls,
                    bufopts("list outgoing calls"))
                    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder,
                    bufopts("add workspace folder"))
                    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder,
                    bufopts("remove workspace folder"))
                    vim.keymap.set('n', '<leader>sc', function()
                        print(vim.inspect(vim.lsp.get_active_clients()[1].server_capabilities))
                    end, bufopts("list lsp server capabilities"))
                    vim.keymap.set('n', '<leader>wl', function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, bufopts("list workspace folders"))
                    vim.keymap.set('n', '<leader>g,', vim.lsp.buf.signature_help, bufopts("signature help"))
                    vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation,
                    bufopts("goto implementation"))
                    vim.keymap.set('n', '<leader>gt', vim.lsp.buf.type_definition,
                    bufopts("goto type definition"))
                    vim.keymap.set('n', '<leader>ds', vim.lsp.buf.document_symbol,
                    bufopts("list document lsp symbols"))
                    vim.keymap.set('n', '<leader>dS', vim.lsp.buf.workspace_symbol,
                    bufopts("list workspace lsp symbols"))
                end
            },
            tools = {
                inlay_hints = {
                    -- automatically set inlay hints (type hints)
                    -- default: true
                    auto = true,
                    -- Only show inlay hints for the current line
                    only_current_line = false,
                    -- whether to show parameter hints with the inlay hints or not
                    -- default: true
                    show_parameter_hints = true,
                    -- prefix for parameter hints
                    -- default: "<-"
                    parameter_hints_prefix = " <- ",
                    -- prefix for all the other hints (type, chaining)
                    -- default: "=>"
                    other_hints_prefix = "=> ",
                    -- whether to align to the length of the longest line in the file
                    max_len_align = false,
                    -- padding from the left if max_len_align is true
                    max_len_align_padding = 1,
                    -- whether to align to the extreme right or not
                    right_align = false,
                    -- padding from the right if right_align is true
                    right_align_padding = 7,
                    -- The color of the hints
                    highlight = "Comment",
                },
            }
        },
    },
}
