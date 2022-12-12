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
telescope.load_extension('sessions_picker')
telescope.load_extension('harpoon')
telescope.load_extension('git_worktree')
telescope.load_extension('zoxide')
telescope.load_extension('file_browser')

require('dir-telescope').setup {respect_gitignore = true}

-- local worktree = require("git-worktree")
-- worktree.on_tree_change(function()
--     local bufs = vim.api.nvim_list_bufs()
--     local bufnr = vim.api.nvim_get_current_buf()
--     print("current_buf" .. bufnr)
--     for _, buf in ipairs(bufs) do
--         if vim.api.nvim_buf_is_loaded(buf) and buf ~= bufnr then
--             print("deleting " .. buf)
--             vim.api.nvim_buf_delete(buf, {})
--         end
--     end
--     vim.cmd [[ e ]]
-- end)
