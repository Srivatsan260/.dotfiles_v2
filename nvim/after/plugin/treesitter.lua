require'nvim-treesitter.configs'.setup {
    ensure_installed = {"python", "rust", "sql", "yaml", "toml", "c"},
    sync_install = false,

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },

    refactor = {
        highlight_definitions = {
            enable = true,
            clear_on_cursor_move = true,
        },
        -- highlight_current_scope = { enable = true },
        smart_rename = {
            enable = true,
            keymaps = {
                smart_rename = 'grr',
            }
        },
        navigation = {
            enable = true,
            keymaps = {
                -- goto_definition = 'gd',
                list_definitions = 'gnd',
                list_definitions_toc = 'gO',
                goto_next_usage = '<a-*>',
                goto_previous_usage = '<a-#>',
            }
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
          show_help = '?',
        },
    }
}
-- vim.cmd [[ autocmd BufReadPost,FileReadPost * normal zR ]]
vim.cmd [[ autocmd BufRead * normal zx zR ]]

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
