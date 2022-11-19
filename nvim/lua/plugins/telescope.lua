local actions = require('telescope.actions')
local telescope = require('telescope')

telescope.setup {
    extensions = {session_picker = {sessions_dir = vim.g['sessions_dir']}},
    pickers = {
        buffers = {
            show_all_buffers = true,
            sort_lastused = true,
            theme = "dropdown",
            mappings = {
                i = {
                    ["<c-d>"] = actions.delete_buffer,
                    ["<c-f>"] = actions.preview_scrolling_down,
                    ["<c-b>"] = actions.preview_scrolling_up,
                },
                n = {
                    ["<c-d>"] = actions.delete_buffer,
                    ["<c-f>"] = actions.preview_scrolling_down,
                    ["<c-b>"] = actions.preview_scrolling_up,
                }
            }
        }
    }
}
telescope.load_extension('sessions_picker')
telescope.load_extension('harpoon')
telescope.load_extension('git_worktree')

require('dir-telescope').setup {respect_gitignore = true}
