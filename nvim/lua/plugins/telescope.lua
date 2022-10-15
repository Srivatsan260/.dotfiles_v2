require'telescope'.setup{
    extensions = {
        session_picker = {
            sessions_dir = vim.g['sessions_dir']
        }
    },
}
require('telescope').load_extension('sessions_picker')
