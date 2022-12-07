local actions = require('telescope.actions')
local telescope = require('telescope')
local z_utils = require("telescope._extensions.zoxide.utils")

telescope.setup {
    defaults = {prompt_prefix = ' '},
    extensions = {
        session_picker = {sessions_dir = vim.g['sessions_dir']},
        zoxide = {
            prompt_title = "[ zoxide ]",
            list_command = "zoxide query -ls",
            mappings = {
                default = {
                    after_action = function(selection)
                        print("Update to (" .. selection.z_score .. ") " .. selection.path)
                    end
                },
                ["<C-s>"] = {
                    before_action = function(_) print("before C-s") end,
                    action = function(selection)
                        vim.cmd("edit " .. selection.path)
                    end
                },
                -- Opens the selected entry in a new split
                ["<C-q>"] = {action = z_utils.create_basic_command("split")},
                -- cd
                ["<C-d>"] = {action = z_utils.create_basic_command("cd")},
                -- edit
                ["<CR>"] = {action = z_utils.create_basic_command("edit")}
            }
        },
        file_browser = {
            -- theme = "dropdown",
            hijack_netrw = false,
            hidden = true
        },
        git_worktree = {theme = "dropdown"}
    },
    pickers = {
        buffers = {
            show_all_buffers = true,
            sort_lastused = true,
            theme = "dropdown",
            mappings = {
                i = {
                    ["<c-d>"] = actions.delete_buffer,
                    ["<c-f>"] = actions.preview_scrolling_down,
                    ["<c-b>"] = actions.preview_scrolling_up
                },
                n = {
                    ["<c-d>"] = actions.delete_buffer,
                    ["<c-f>"] = actions.preview_scrolling_down,
                    ["<c-b>"] = actions.preview_scrolling_up
                }
            }
        }
    }
}
telescope.load_extension('sessions_picker')
telescope.load_extension('harpoon')
telescope.load_extension('git_worktree')
telescope.load_extension('zoxide')
telescope.load_extension('file_browser')

require('dir-telescope').setup {respect_gitignore = true}

local worktree = require("git-worktree")

worktree.on_tree_change(function(_, _)
    if vim.env.SET_PYTHON_PATH ~= nil then
        vim.env.PYTHONPATH = vim.fn.getcwd()
        vim.env.AIRFLOW__CORE__DAGS_FOLDER = vim.fn.getcwd() .. '/dags'
        print(vim.env.PYTHONPATH, vim.env.AIRFLOW__CORE__DAGS_FOLDER)
    end
end)
