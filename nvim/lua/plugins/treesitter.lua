return {
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-context',
            'nvim-treesitter/nvim-treesitter-textobjects',
            'nvim-treesitter/playground'
        },
        build = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup {
                -- ensure_installed = {"python", "rust", "sql", "yaml", "toml", "c", "http", "json"},
                sync_install = false,
                highlight = {enable = true, additional_vim_regex_highlighting = false},
                incremental_selection = {
                    enable = false,
                    keymaps = {
                        init_selection = "<leader><CR>",
                        node_incremental = "<CR>",
                        node_decremental = "-"
                    }
                },
                playground = {
                    enable = true,
                    disable = {},
                    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
                    persist_queries = false, -- Whether the query persists across vim sessions
                    keybindings = {
                        toggle_query_editor = 'o',
                        toggle_hl_groups = 'i',
                        toggle_injected_languages = 't',
                        toggle_anonymous_nodes = 'a',
                        toggle_language_display = 'I',
                        focus_language = 'f',
                        unfocus_language = 'F',
                        update = 'R',
                        goto_node = '<cr>',
                        show_help = '?'
                    }
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
                            ["ic"] = {query = "@class.inner", desc = "Select inner part of a class region"},
                            ["ig"] = "@conditional.inner",
                            ["ag"] = "@conditional.outer",
                            ["il"] = "@loop.inner",
                            ["al"] = "@loop.outer"
                        },
                        -- You can choose the select mode (default is charwise 'v')
                        --
                        -- Can also be a function which gets passed a table with the keys
                        -- * query_string: eg '@function.inner'
                        -- * method: eg 'v' or 'o'
                        -- and should return the mode ('v', 'V', or '<c-v>') or a table
                        -- mapping query_strings to modes.
                        selection_modes = {
                            ['@parameter.outer'] = 'v', -- charwise
                            ['@function.outer'] = 'V', -- linewise
                            ['@class.outer'] = 'V' -- linewise
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
                        include_surrounding_whitespace = false
                    }
                },
                rainbow = {enable = true, extended_mode = true}
            }
        end,
        keys = {
            {"<leader>th", "<cmd>TSBufToggle highlight<CR>", desc = "toggle treesitter highlights"},
            {"<leader>tp", "<cmd>TSPlaygroundToggle<CR>", desc = "toggle treesitter playground"},
        }
    },
    {'nvim-treesitter/nvim-treesitter-context', build = ":TSUpdate"},
    {'nvim-treesitter/nvim-treesitter-textobjects', build = ":TSUpdate"},
    {'nvim-treesitter/playground', build = ":TSUpdate"}
}
