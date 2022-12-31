local telescope_ok, telescope = pcall(require, "telescope")
if not telescope_ok then return end

local actions = require('telescope.actions')

local z_utils_ok, z_utils = pcall(require, "telescope._extensions.zoxide.utils")
local zoxide_opts
if z_utils_ok then
    zoxide_opts = {
        prompt_title = "[ zoxide ]",
        list_command = "zoxide query -ls",
        mappings = {
            default = {
                after_action = function(selection)
                    print("Update to (" .. selection.z_score .. ") " .. selection.path)
                end
            },
            ["<C-s>"] = {
                before_action = function(_)
                    print("before C-s")
                end,
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
    }
else
    zoxide_opts = {}
end

telescope.setup {
    defaults = {prompt_prefix = ' '},
    extensions = {
        session_picker = {sessions_dir = vim.g.sessions_dir},
        zoxide = zoxide_opts,
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
            theme = "ivy",
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
pcall(telescope.load_extension, 'sessions_picker')
pcall(telescope.load_extension, 'harpoon')
pcall(telescope.load_extension, 'git_worktree')
pcall(telescope.load_extension, 'zoxide')
pcall(telescope.load_extension, 'file_browser')

local dir_ok, dir_telescope = pcall(require, "dir-telescope")
if dir_ok then dir_telescope.setup {hidden = true} end
