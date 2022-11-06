require'telescope'.setup{
    extensions = {
        session_picker = {
            sessions_dir = vim.g['sessions_dir']
        }
    },
}
require('telescope').load_extension('sessions_picker')
require('telescope').load_extension('harpoon')

require('dir-telescope').setup {
    respect_gitignore = true,
}

require('telescope').load_extension('git_worktree')
