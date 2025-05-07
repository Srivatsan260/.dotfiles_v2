return {
    {
        "williamboman/mason.nvim",
        dependencies = { "williamboman/mason-lspconfig.nvim" },
        keys = {
            { "<leader>M", "<cmd>Mason<CR>", desc = "open Mason" },
        },
        event = { "BufReadPre", "BufNewFile" },
        cmd = "Mason",
    },
    {
        "VonHeikemen/lsp-zero.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            {
                "neovim/nvim-lspconfig",
                dependencies = { "williamboman/mason.nvim" },
            },
            {
                "folke/neodev.nvim",
                config = function()
                    require("neodev").setup()
                end,
            },
            "ray-x/lsp_signature.nvim",
            "j-hui/fidget.nvim",
            "simrat39/symbols-outline.nvim",
            "folke/trouble.nvim",
            { "nvim-java/nvim-java", ft = "java" },
            -- {
            --     "tjdevries/ocaml.nvim",
            --     build = function()
            --         require("ocaml").update()
            --     end
            -- },
        },
        config = function()
            local ok, wf = pcall(require, "vim.lsp._watchfiles")
            -- if ok then
            --     -- disable lsp watcher. Too slow on linux
            --     wf._watchfunc = function()
            --         print("lsp watcher disabled")
            --         return function() end
            --     end
            -- end

            local lsp = require("lsp-zero")
            lsp.preset("recommended")
            lsp.ensure_installed({
                "basedpyright",
                "ts_ls",
                "html",
                "cssls",
                "emmet_ls",
                "lua_ls",
                "clangd",
                "marksman",
            })
            lsp.set_preferences({
                set_lsp_keymaps = false,
                manage_nvim_cmp = false,
                sign_icons = { error = "E", warn = "W", hint = "H", info = "I" },
            })
            lsp.configure("lua_ls", {
                settings = {
                    Lua = {
                        workspace = { library = vim.api.nvim_get_runtime_file("", true) },
                        diagnostics = { globals = { "vim" } },
                        telemetry = { enable = false },
                        completion = { callSnippet = "Replace" },
                    },
                },
            })
            local on_attach = function(_, bufnr)
                vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

                local bufopts = function(desc)
                    return { noremap = true, silent = true, buffer = bufnr, desc = desc }
                end
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts("goto declaration"))
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts("goto definition"))
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
                vim.keymap.set("n", "<leader>ac", vim.lsp.buf.code_action, bufopts("code actions"))
                vim.keymap.set(
                    "n",
                    "<leader>rn",
                    vim.lsp.buf.rename,
                    bufopts("rename current symbol")
                )
                -- if vim.bo.filetype == 'python' then
                --     vim.keymap.set('n', '<leader>-', '<cmd>!isort %<CR>', bufopts("isort"))
                if vim.bo.filetype == "lua" then
                    vim.keymap.set("n", "<leader>=", "<cmd>!stylua %<CR>", bufopts("stylua"))
                else
                    vim.keymap.set("n", "<leader>=", vim.lsp.buf.format, bufopts("format document"))
                end
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

            lsp.on_attach(on_attach)

            require("lspconfig").basedpyright.setup({
                basedpyright = {
                    analysis = {
                        diagnosticMode = "openFilesOnly",
                    },
                    extends = "~/dotfiles/basedpyrightconfig.json"
                },
            })

            -- require("ocaml").setup()

            require("lspconfig.configs").dbt = {
                default_config = {
                    cmd = {'dbt-language-server', '--stdio'},
                    filetypes = {'dbt', 'sql', 'yml', 'md'},
                    root_dir = function(fname)
                        return require('lspconfig').util.root_pattern('dbt_project.yml')(fname)
                    end,
                },
            }
            require("lspconfig").dbt.setup({
                init_options = {
                    pythonInfo = { path = "python" },
                    lspMode = "dbtProject",
                    enableSnowflakeSyntaxCheck = false
                },
                on_attach = on_attach
            })

            require('java').setup()

            lsp.setup()

            vim.diagnostic.config({
                virtual_text = true,
                signs = true,
                update_in_insert = false,
                underline = true,
                severity_sort = true,
                float = true,
            })

        end,
    },

    {
        "simrat39/rust-tools.nvim",
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
