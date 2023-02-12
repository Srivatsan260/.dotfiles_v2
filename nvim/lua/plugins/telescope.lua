return {
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'JoseConseco/telescope_sessions_picker.nvim',
            'jvgrootveld/telescope-zoxide',
            'kkharji/sqlite.lua',
            'nvim-lua/plenary.nvim',
            'nvim-lua/popup.nvim',
            'nvim-telescope/telescope-file-browser.nvim',
            'nvim-telescope/telescope-frecency.nvim',
            'princejoogie/dir-telescope.nvim',
        },
        lazy = true,
        keys = {
            {"<C-p>", "<cmd>Telescope find_files hidden=True<CR>", desc = "Telescope find_files"},
            {"<leader>fb", "<cmd>Telescope file_browser hidden=True<CR>", desc = "Telescope file_browser"},
            {"<leader>cs", "<cmd>Telescope colorscheme<CR>", desc = "List colorschemes in telescope"},
            {"<leader>ct", "<cmd>! ctags -R<CR>", desc = "generate ctags"},
            {"<leader>fd", "<cmd>FileInDirectory<CR>", desc = "find file in directory"},
            {"<leader>pd", "<cmd>GrepInDirectory<CR>", desc = "grep in directory"},
            {"<leader>ff", "<cmd>Telescope live_grep<CR>", desc = "grep in workspace"},
            {"<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "fuzzy find in current buffer"},
            {"<leader>?", "<cmd>Telescope oldfiles<CR>", desc = "show recent files using telescope"},
            {"<leader>b", "<cmd>Telescope buffers<CR>", desc = "list open buffers"},
            {"<leader>cd", "<cmd>Telescope zoxide list<CR>", desc = "list directories using zoxide"},
            {"<leader>tR", "<cmd>Telescope resume<CR>", desc = "resume last telescope search"},
            {"<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "show help tags in Telescope"},
            {"<leader>tg", function() require("telescope.builtin").tags({ctags_file = "./tags"}) end, desc = "List all tags in workspace"},
            {"<leader>gb", "<cmd>Telescope git_branches<CR>", desc = "list git branches"},
            {"<leader>gr", "<cmd>Telescope grep_string<CR>", desc = "grep for cword in workspace"},
            {"<leader>gR", function()
                local search = vim.fn.input({prompt = "Search for: ", default = ""})
                if search == "" then return end
                vim.cmd("Telescope grep_string search=" .. search)
            end, desc = "grep for user input in workspace"},
            {"<leader>gs", "<cmd>Telescope git_status<CR>", desc = "show git status in Telescope"},
            {"<leader>ft", "<cmd>Telescope filetypes<CR>", desc = "list available filetypes in Telescope"},
            {"<leader>jj", "<cmd>Telescope jumplist<CR>", desc = "open jumplist in Telescope"},
            {
                "<leader>gwl", function()
                    require("telescope").extensions.git_worktree.git_worktrees()
                end, desc = "list git worktrees in Telescope"
            }
        },
        config = function()
            local telescope = require("telescope")
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
                defaults = {
                    prompt_prefix = ' ',
                    layout_strategy = "current_buffer",
                },
                extensions = {
                    session_picker = {sessions_dir = vim.g.sessions_dir},
                    zoxide = zoxide_opts,
                    file_browser = {
                        hijack_netrw = false,
                        hidden = true
                    },
                },
                pickers = {
                    find_files = {
                        find_command = {"rg", "--ignore", "-L", "--hidden", "--files"},
                    },
                    buffers = {
                        show_all_buffers = true,
                        sort_lastused = true,
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
            local extensions = {
                'sessions_picker',
                'harpoon',
                'git_worktree',
                'zoxide',
                'file_browser',
                'frecency',
            }
            for _, ext in pairs(extensions) do
                pcall(telescope.load_extension, ext)
            end

            local dir_ok, dir_telescope = pcall(require, "dir-telescope")
            if dir_ok then dir_telescope.setup {hidden = true} end
        end
    },
}
