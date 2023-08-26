return {
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            {
                "nvim-treesitter/nvim-treesitter-context",
                build = ":TSUpdate",
                config = function()
                    require("treesitter-context").setup({
                        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
                        max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
                        trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
                        min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
                        patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
                            -- For all filetypes
                            -- Note that setting an entry here replaces all other patterns for this entry.
                            -- By setting the 'default' entry below, you can control which nodes you want to
                            -- appear in the context window.
                            default = {
                                "class",
                                "function",
                                "method",
                                "for",
                                "while",
                                "if",
                                "switch",
                                "case",
                                "interface",
                                "struct",
                                "enum",
                            },
                            -- Patterns for specific filetypes
                            -- If a pattern is missing, *open a PR* so everyone can benefit.
                            tex = { "chapter", "section", "subsection", "subsubsection" },
                            haskell = { "adt" },
                            rust = { "impl_item" },
                            terraform = { "block", "object_elem", "attribute" },
                            scala = { "object_definition" },
                            vhdl = {
                                "process_statement",
                                "architecture_body",
                                "entity_declaration",
                            },
                            markdown = { "section" },
                            elixir = {
                                "anonymous_function",
                                "arguments",
                                "block",
                                "do_block",
                                "list",
                                "map",
                                "tuple",
                                "quoted_content",
                            },
                            json = { "pair" },
                            typescript = { "export_statement" },
                            yaml = { "block_mapping_pair" },
                        },
                        exact_patterns = {
                            -- Example for a specific filetype with Lua patterns
                            -- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
                            -- exactly match "impl_item" only)
                            -- rust = true,
                        },

                        -- [!] The options below are exposed but shouldn't require your attention,
                        --     you can safely ignore them.

                        zindex = 20, -- The Z-index of the context window
                        mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
                        -- Separator between context and content. Should be a single character string, like '-'.
                        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
                        separator = nil,
                    })
                end,
                keys = {
                    {
                        "<leader>tx",
                        "<cmd>TSContextToggle<CR>",
                        desc = "toggle treesitter-context",
                    },
                },
            },
            { "nvim-treesitter/nvim-treesitter-textobjects", build = ":TSUpdate" },
            { "nvim-treesitter/playground", build = ":TSUpdate" },
            { "yioneko/nvim-yati" },
        },
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                -- ensure_installed = {"python", "rust", "sql", "yaml", "toml", "c", "http", "json"},
                sync_install = false,
                highlight = { enable = true, additional_vim_regex_highlighting = false },
                indent = {
                    enable = false,
                },
                yati = {
                    enable = true,
                    -- Whether to enable lazy mode (recommend to enable this if bad indent happens frequently)
                    default_lazy = true,

                    -- Determine the fallback method used when we cannot calculate indent by tree-sitter
                    --   "auto": fallback to vim auto indent
                    --   "asis": use current indent as-is
                    --   "cindent": see `:h cindent()`
                    -- Or a custom function return the final indent result.
                    default_fallback = "auto",
                },
                incremental_selection = {
                    enable = false,
                    keymaps = {
                        init_selection = "<leader><CR>",
                        node_incremental = "<CR>",
                        node_decremental = "-",
                    },
                },
                playground = {
                    enable = true,
                    disable = {},
                    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
                    persist_queries = false, -- Whether the query persists across vim sessions
                    keybindings = {
                        toggle_query_editor = "o",
                        toggle_hl_groups = "i",
                        toggle_injected_languages = "t",
                        toggle_anonymous_nodes = "a",
                        toggle_language_display = "I",
                        focus_language = "f",
                        unfocus_language = "F",
                        update = "R",
                        goto_node = "<cr>",
                        show_help = "?",
                    },
                },
                textobjects = {
                    select = {
                        enable = true,
                        -- Automatically jump forward to textobj, similar to targets.vim
                        lookahead = true,
                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            -- You can optionally set descriptions to the mappings (used in the desc parameter of
                            -- nvim_buf_set_keymap) which plugins like which-key display
                            ["ic"] = {
                                query = "@class.inner",
                                desc = "Select inner part of a class region",
                            },
                            ["ig"] = "@conditional.inner",
                            ["ag"] = "@conditional.outer",
                            ["il"] = "@loop.inner",
                            ["al"] = "@loop.outer",
                        },
                        -- You can choose the select mode (default is charwise 'v')
                        --
                        -- Can also be a function which gets passed a table with the keys
                        -- * query_string: eg '@function.inner'
                        -- * method: eg 'v' or 'o'
                        -- and should return the mode ('v', 'V', or '<c-v>') or a table
                        -- mapping query_strings to modes.
                        selection_modes = {
                            ["@parameter.outer"] = "v", -- charwise
                            ["@function.outer"] = "V", -- linewise
                            ["@class.outer"] = "V", -- linewise
                        },
                        -- If you set this to `true` (default is `false`) then any textobject is
                        -- extended to include preceding or succeeding whitespace. Succeeding
                        -- whitespace has priority in order to act similarly to eg the built-in
                        -- `ap`.
                        --
                        -- Can also be a function which gets passed a table with the keys
                        -- * query_string: eg '@function.inner'
                        -- * selection_mode: eg 'v'
                        -- and should return true of false
                        include_surrounding_whitespace = false,
                    },
                },
                rainbow = { enable = true, extended_mode = true },
            })
        end,
        keys = {
            {
                "<leader>th",
                "<cmd>TSBufToggle highlight<CR>",
                desc = "toggle treesitter highlights",
            },
            { "<leader>tp", "<cmd>TSPlaygroundToggle<CR>", desc = "toggle treesitter playground" },
        },
        event = { "BufReadPost" },
    },
}
