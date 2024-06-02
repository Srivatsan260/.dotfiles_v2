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
            {
                "mfussenegger/nvim-jdtls",
                config = function()
                    -- java lsp setup
                    local java_cmds = vim.api.nvim_create_augroup("java_cmds", { clear = true })
                    local cache_vars = {}

                    local root_files = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }

                    local features = {
                        -- change this to `true` to enable codelens
                        codelens = true,

                        -- change this to `true` if you have `nvim-dap`,
                        -- `java-test` and `java-debug-adapter` installed
                        debugger = false,
                    }

                    ---@return table
                    local function get_jdtls_paths()
                        if cache_vars.paths then
                            return cache_vars.paths
                        end

                        local path = {}

                        path.data_dir = vim.fn.stdpath("cache") .. "/nvim-jdtls"

                        local jdtls_install =
                            require("mason-registry").get_package("jdtls"):get_install_path()

                        path.java_agent = jdtls_install .. "/lombok.jar"
                        path.launcher_jar =
                            vim.fn.glob(jdtls_install .. "/plugins/org.eclipse.equinox.launcher_*.jar")

                        if vim.fn.has("mac") == 1 then
                            path.platform_config = jdtls_install .. "/config_mac"
                        elseif vim.fn.has("unix") == 1 then
                            path.platform_config = jdtls_install .. "/config_linux"
                        elseif vim.fn.has("win32") == 1 then
                            path.platform_config = jdtls_install .. "/config_win"
                        end

                        path.bundles = {}

                        ---
                        -- Include java-test bundle if present
                        ---
                        local java_test_path =
                            require("mason-registry").get_package("java-test"):get_install_path()

                        local java_test_bundle =
                            vim.split(vim.fn.glob(java_test_path .. "/extension/server/*.jar"), "\n")

                        if java_test_bundle[1] ~= "" then
                            vim.list_extend(path.bundles, java_test_bundle)
                        end

                        ---
                        -- Include java-debug-adapter bundle if present
                        ---
                        local java_debug_path =
                            require("mason-registry").get_package("java-debug-adapter"):get_install_path()

                        local java_debug_bundle = vim.split(
                            vim.fn.glob(
                                java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar"
                            ),
                            "\n"
                        )

                        if java_debug_bundle[1] ~= "" then
                            vim.list_extend(path.bundles, java_debug_bundle)
                        end

                        cache_vars.paths = path

                        return path
                    end

                    ---@param bufnr integer
                    ---@return nil
                    local function enable_codelens(bufnr)
                        pcall(vim.lsp.codelens.refresh)

                        vim.api.nvim_create_autocmd("BufWritePost", {
                            buffer = bufnr,
                            group = java_cmds,
                            desc = "refresh codelens",
                            callback = function()
                                pcall(vim.lsp.codelens.refresh)
                            end,
                        })
                    end

                    ---@param bufnr integer
                    ---@return nil
                    local function enable_debugger(bufnr)
                        require("jdtls").setup_dap({ hotcodereplace = "auto" })
                        require("jdtls.dap").setup_dap_main_class_configs()

                        local opts = { buffer = bufnr }
                        vim.keymap.set(
                            "n",
                            "<leader>df",
                            "<cmd>lua require('jdtls').test_class()<cr>",
                            opts
                        )
                        vim.keymap.set(
                            "n",
                            "<leader>dn",
                            "<cmd>lua require('jdtls').test_nearest_method()<cr>",
                            opts
                        )
                    end

                    ---@param client table
                    ---@param bufnr integer
                    ---@return nil
                    local function jdtls_on_attach(client, bufnr)
                        if features.debugger then
                            enable_debugger(bufnr)
                        end

                        if features.codelens then
                            enable_codelens(bufnr)
                        end

                        -- The following mappings are based on the suggested usage of nvim-jdtls
                        -- https://github.com/mfussenegger/nvim-jdtls#usage

                        local opts = { buffer = bufnr }
                        vim.keymap.set(
                            "n",
                            "<A-o>",
                            "<cmd>lua require('jdtls').organize_imports()<cr>",
                            opts
                        )
                        vim.keymap.set("n", "crv", "<cmd>lua require('jdtls').extract_variable()<cr>", opts)
                        vim.keymap.set(
                            "x",
                            "crv",
                            "<esc><cmd>lua require('jdtls').extract_variable(true)<cr>",
                            opts
                        )
                        vim.keymap.set("n", "crc", "<cmd>lua require('jdtls').extract_constant()<cr>", opts)
                        vim.keymap.set(
                            "x",
                            "crc",
                            "<esc><cmd>lua require('jdtls').extract_constant(true)<cr>",
                            opts
                        )
                        vim.keymap.set(
                            "x",
                            "crm",
                            "<esc><Cmd>lua require('jdtls').extract_method(true)<cr>",
                            opts
                        )
                    end

                    ---@param event any
                    ---@return nil
                    local function jdtls_setup(event)
                        local jdtls = require("jdtls")

                        local path = get_jdtls_paths()
                        local data_dir = path.data_dir
                            .. "/"
                            .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

                        if cache_vars.capabilities == nil then
                            jdtls.extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

                            local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
                            cache_vars.capabilities = vim.tbl_deep_extend(
                                "force",
                                vim.lsp.protocol.make_client_capabilities(),
                                ok_cmp and cmp_lsp.default_capabilities() or {}
                            )
                        end

                        -- The command that starts the language server
                        -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
                        local cmd = {
                            -- 💀
                            "java",
                            "-Declipse.application=org.eclipse.jdt.ls.core.id1",
                            "-Dosgi.bundles.defaultStartLevel=4",
                            "-Declipse.product=org.eclipse.jdt.ls.core.product",
                            "-Dlog.protocol=true",
                            "-Dlog.level=ALL",
                            "-javaagent:" .. path.java_agent,
                            "-Xms1g",
                            "--add-modules=ALL-SYSTEM",
                            "--add-opens",
                            "java.base/java.util=ALL-UNNAMED",
                            "--add-opens",
                            "java.base/java.lang=ALL-UNNAMED", -- 💀
                            "-jar",
                            path.launcher_jar, -- 💀
                            "-configuration",
                            path.platform_config, -- 💀
                            "-data",
                            data_dir,
                        }

                        local lsp_settings = {
                            java = {
                                -- jdt = {
                                --   ls = {
                                --     vmargs = "-XX:+UseParallelGC -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90 -Dsun.zip.disableMemoryMapping=true -Xmx1G -Xms100m"
                                --   }
                                -- },
                                eclipse = { downloadSources = true },
                                configuration = {
                                    updateBuildConfiguration = "interactive",
                                    runtimes = path.runtimes,
                                },
                                maven = { downloadSources = true },
                                implementationsCodeLens = { enabled = true },
                                referencesCodeLens = { enabled = true },
                                -- inlayHints = {
                                --   parameterNames = {
                                --     enabled = 'all' -- literals, all, none
                                --   }
                                -- },
                                format = {
                                    enabled = true,
                                    -- settings = {
                                    --   profile = 'asdf'
                                    -- },
                                },
                            },
                            signatureHelp = { enabled = true },
                            completion = {
                                favoriteStaticMembers = {
                                    "org.hamcrest.MatcherAssert.assertThat",
                                    "org.hamcrest.Matchers.*",
                                    "org.hamcrest.CoreMatchers.*",
                                    "org.junit.jupiter.api.Assertions.*",
                                    "java.util.Objects.requireNonNull",
                                    "java.util.Objects.requireNonNullElse",
                                    "org.mockito.Mockito.*",
                                },
                            },
                            contentProvider = { preferred = "fernflower" },
                            extendedClientCapabilities = jdtls.extendedClientCapabilities,
                            sources = {
                                organizeImports = { starThreshold = 9999, staticStarThreshold = 9999 },
                            },
                            codeGeneration = {
                                toString = {
                                    template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
                                },
                                useBlocks = true,
                            },
                        }

                        -- This starts a new client & server,
                        -- or attaches to an existing client & server depending on the `root_dir`.
                        jdtls.start_or_attach({
                            cmd = cmd,
                            settings = lsp_settings,
                            on_attach = jdtls_on_attach,
                            capabilities = cache_vars.capabilities,
                            root_dir = jdtls.setup.find_root(root_files),
                            flags = { allow_incremental_sync = true },
                            init_options = { bundles = path.bundles },
                        })
                    end

                    vim.api.nvim_create_autocmd("FileType", {
                        group = java_cmds,
                        pattern = { "java" },
                        desc = "Setup jdtls",
                        callback = jdtls_setup,
                    })
                end
            },
            {
                "tjdevries/ocaml.nvim",
                build = function()
                    require("ocaml").update()
                end
            },
        },
        config = function()
            local ok, wf = pcall(require, "vim.lsp._watchfiles")
            if ok then
                -- disable lsp watcher. Too slow on linux
                wf._watchfunc = function()
                    print("lsp watcher disabled")
                    return function() end
                end
            end

            local lsp = require("lsp-zero")
            lsp.preset("recommended")
            lsp.ensure_installed({
                "pyright",
                "tsserver",
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

            require("lspconfig").pyright.setup({
                settings = {
                    python = {
                        analysis = {
                            autoSearchPaths = true,
                            useLibraryCodeForTypes = true,
                        },
                    },
                },
            })

            require("ocaml").setup()

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
