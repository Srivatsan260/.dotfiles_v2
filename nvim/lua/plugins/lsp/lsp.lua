return {
    { "simrat39/symbols-outline.nvim" },
    { "folke/trouble.nvim" },
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            {
                "mason-org/mason.nvim",
                keys = {
                    { "<leader>M", "<cmd>Mason<CR>", desc = "open Mason" },
                },
                event = "VeryLazy",
            },
            {
                "neovim/nvim-lspconfig",
            },
            {
                "folke/neodev.nvim",
            }
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({
                handlers = {
                    -- this first function is the "default handler"
                    -- it applies to every language server without a "custom handler"
                    function(server_name)
                        require("lspconfig")[server_name].setup({})
                    end,

                    -- this is the "custom handler" for `basedpyright`
                    basedpyright = function()
                        require("lspconfig").basedpyright.setup({
                            settings = {
                                basedpyright = {
                                    analysis = {
                                        diagnosticMode = "workspace",
                                        inlayHints = {
                                            variableTypes = true,
                                            callArgumentNames = true,
                                            functionReturnTypes = true,
                                            genericTypes = true,
                                        },
                                    },
                                },
                            },
                        })
                    end,

                    lua_ls = function()
                        require('lspconfig').lua_ls.setup({
                            settings = {
                                Lua = {
                                    telemetry = {
                                        enable = false
                                    },
                                },
                            },
                            on_init = function(client)
                                local join = vim.fs.joinpath
                                local path = client.workspace_folders[1].name

                                -- Don't do anything if there is project local config
                                if vim.uv.fs_stat(join(path, '.luarc.json'))
                                    or vim.uv.fs_stat(join(path, '.luarc.jsonc'))
                                then
                                    return
                                end

                                local nvim_settings = {
                                    runtime = {
                                        -- Tell the language server which version of Lua you're using
                                        version = 'LuaJIT',
                                    },
                                    diagnostics = {
                                        -- Get the language server to recognize the `vim` global
                                        globals = {'vim'}
                                    },
                                    workspace = {
                                        checkThirdParty = false,
                                        library = {
                                            -- Make the server aware of Neovim runtime files
                                            vim.env.VIMRUNTIME,
                                            vim.fn.stdpath('config'),
                                        },
                                    },
                                }

                                client.config.settings.Lua = vim.tbl_deep_extend(
                                    'force',
                                    client.config.settings.Lua,
                                    nvim_settings
                                )
                            end,
                        })
                    end
                },
            })

            vim.keymap.set("n", "<leader>ac", vim.lsp.buf.code_action)
            vim.keymap.set("n", "grr", "<cmd>Telescope lsp_references<CR>")
            vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation)
            vim.keymap.set("n", "<leader>gt", vim.lsp.buf.type_definition)

            vim.diagnostic.config({
                virtual_text = true,
                signs = true,
                update_in_insert = false,
                underline = true,
                severity_sort = true,
                float = true,
            })
        end
    },
    {
        "simrat39/rust-tools.nvim",
        enabled = false,
        ft = "rust",
        opts = {
            server = {
                on_attach = function(_, bufnr)
                    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
                    local bufopts = function(desc)
                        return { noremap = true, silent = true, buffer = bufnr, desc = desc }
                    end
                    vim.keymap.set(
                        "n",
                        "K",
                        require("rust-tools").hover_actions.hover_actions,
                        bufopts("hover actions")
                    )
                    vim.keymap.set(
                        "n",
                        "<leader>ac",
                        require("rust-tools").code_action_group.code_action_group,
                        bufopts("")
                    )
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts("goto declaration"))
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts("goto definition"))
                    vim.keymap.set(
                        "n",
                        "<leader>gi",
                        vim.lsp.buf.implementation,
                        bufopts("goto implementation")
                    )
                    vim.keymap.set(
                        "n",
                        "gr",
                        "<cmd>Telescope lsp_references<CR>",
                        bufopts("find lsp references")
                    )
                    vim.keymap.set("n", "g,", vim.lsp.buf.signature_help, bufopts("signature help"))
                    vim.keymap.set("n", "<leader>=", vim.lsp.buf.format, bufopts("format document"))
                    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts("rename symbol"))
                    vim.keymap.set(
                        "n",
                        "<leader>ai",
                        vim.lsp.buf.incoming_calls,
                        bufopts("list incoming calls")
                    )
                    vim.keymap.set(
                        "n",
                        "<leader>ao",
                        vim.lsp.buf.outgoing_calls,
                        bufopts("list outgoing calls")
                    )
                    vim.keymap.set(
                        "n",
                        "<leader>wa",
                        vim.lsp.buf.add_workspace_folder,
                        bufopts("add workspace folder")
                    )
                    vim.keymap.set(
                        "n",
                        "<leader>wr",
                        vim.lsp.buf.remove_workspace_folder,
                        bufopts("remove workspace folder")
                    )
                    vim.keymap.set("n", "<leader>sc", function()
                        print(vim.inspect(vim.lsp.get_clients()[1].server_capabilities))
                    end, bufopts("list lsp server capabilities"))
                    vim.keymap.set("n", "<leader>wl", function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, bufopts("list workspace folders"))
                    vim.keymap.set(
                        "n",
                        "<leader>g,",
                        vim.lsp.buf.signature_help,
                        bufopts("signature help")
                    )
                    vim.keymap.set(
                        "n",
                        "<leader>gi",
                        vim.lsp.buf.implementation,
                        bufopts("goto implementation")
                    )
                    vim.keymap.set(
                        "n",
                        "<leader>gt",
                        vim.lsp.buf.type_definition,
                        bufopts("goto type definition")
                    )
                    vim.keymap.set(
                        "n",
                        "<leader>ds",
                        vim.lsp.buf.document_symbol,
                        bufopts("list document lsp symbols")
                    )
                    vim.keymap.set(
                        "n",
                        "<leader>dS",
                        vim.lsp.buf.workspace_symbol,
                        bufopts("list workspace lsp symbols")
                    )
                end,
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
            },
        },
    },
    {
        "scalameta/nvim-metals",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "scala", "sbt" },
                callback = function()
                    local metals_config = require("metals").bare_config()
                    metals_config.settings = {
                        showImplicitArguments = true,
                    }
                    metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()
                    metals_config.on_attach = function(_, bufnr)
                        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

                        local bufopts = function(desc)
                            return { noremap = true, silent = true, buffer = bufnr, desc = desc }
                        end
                        vim.keymap.set(
                            "n",
                            "gD",
                            vim.lsp.buf.declaration,
                            bufopts("goto declaration")
                        )
                        vim.keymap.set(
                            "n",
                            "gd",
                            vim.lsp.buf.definition,
                            bufopts("goto definition")
                        )
                        vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts("help"))
                        vim.keymap.set(
                            "n",
                            "gr",
                            "<cmd>Telescope lsp_references<CR>",
                            bufopts("find lsp references")
                        )
                        vim.keymap.set(
                            "n",
                            "<leader>g,",
                            vim.lsp.buf.signature_help,
                            bufopts("signature help")
                        )
                        vim.keymap.set(
                            "n",
                            "<leader>gi",
                            vim.lsp.buf.implementation,
                            bufopts("goto implementation")
                        )
                        vim.keymap.set(
                            "n",
                            "<leader>gt",
                            vim.lsp.buf.type_definition,
                            bufopts("goto type definition")
                        )
                        vim.keymap.set(
                            "n",
                            "<leader>ds",
                            vim.lsp.buf.document_symbol,
                            bufopts("list document lsp symbols")
                        )
                        vim.keymap.set(
                            "n",
                            "<leader>dS",
                            vim.lsp.buf.workspace_symbol,
                            bufopts("list workspace lsp symbols")
                        )
                        vim.keymap.set(
                            "n",
                            "<leader>ac",
                            vim.lsp.buf.code_action,
                            bufopts("code actions")
                        )
                        vim.keymap.set(
                            "n",
                            "<leader>rn",
                            vim.lsp.buf.rename,
                            bufopts("rename current symbol")
                        )
                        vim.keymap.set(
                            "n",
                            "<leader>=",
                            vim.lsp.buf.format,
                            bufopts("format document")
                        )
                        vim.keymap.set(
                            "n",
                            "<leader>ai",
                            vim.lsp.buf.incoming_calls,
                            bufopts("list incoming calls")
                        )
                        vim.keymap.set(
                            "n",
                            "<leader>ao",
                            vim.lsp.buf.outgoing_calls,
                            bufopts("list outgoing calls")
                        )
                        vim.keymap.set(
                            "n",
                            "<leader>wa",
                            vim.lsp.buf.add_workspace_folder,
                            bufopts("add workspace folder")
                        )
                        vim.keymap.set(
                            "n",
                            "<leader>wr",
                            vim.lsp.buf.remove_workspace_folder,
                            bufopts("remove workspace folder")
                        )
                        vim.keymap.set("n", "<leader>sc", function()
                            print(vim.inspect(vim.lsp.get_clients()[1].server_capabilities))
                        end, bufopts("list lsp server capabilities"))
                        vim.keymap.set("n", "<leader>wl", function()
                            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                        end, bufopts("list workspace folders"))
                    end
                    require("metals").initialize_or_attach(metals_config)
                end,
                group = nvim_metals_group,
            })
        end,
    },
}
