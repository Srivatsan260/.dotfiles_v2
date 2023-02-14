return {
    {
        'lewis6991/gitsigns.nvim',
        opts = {
            signs = {
                add = {hl = 'GitSignsAdd', text = '│', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn'},
                change = {
                    hl = 'GitSignsChange',
                    text = '│',
                    numhl = 'GitSignsChangeNr',
                    linehl = 'GitSignsChangeLn'
                },
                delete = {
                    hl = 'GitSignsDelete',
                    text = '_',
                    numhl = 'GitSignsDeleteNr',
                    linehl = 'GitSignsDeleteLn'
                },
                topdelete = {
                    hl = 'GitSignsDelete',
                    text = '‾',
                    numhl = 'GitSignsDeleteNr',
                    linehl = 'GitSignsDeleteLn'
                },
                changedelete = {
                    hl = 'GitSignsChange',
                    text = '~',
                    numhl = 'GitSignsChangeNr',
                    linehl = 'GitSignsChangeLn'
                },
                untracked = {
                    hl = 'GitSignsAdd',
                    text = '┆',
                    numhl = 'GitSignsAddNr',
                    linehl = 'GitSignsAddLn'
                }
            },
            signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
            numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
            linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
            word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
            watch_gitdir = {interval = 1000, follow_files = true},
            attach_to_untracked = true,
            current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
                delay = 250,
                ignore_whitespace = false
            },
            current_line_blame_formatter = '  <author>, <author_time:%Y-%m-%d> - <summary>',
            sign_priority = 6,
            update_debounce = 100,
            status_formatter = nil, -- Use default
            max_file_length = 40000, -- Disable if file is longer than this (in lines)
            preview_config = {
                -- Options passed to nvim_open_win
                border = 'single',
                style = 'minimal',
                relative = 'cursor',
                row = 0,
                col = 1
            },
            yadm = {enable = false}
        },
        keys = {
            {"]g", "<cmd>Gitsigns next_hunk<CR>", desc = "next hunk in buffer", mode = {"n", "v"}},
            {"[g", "<cmd>Gitsigns prev_hunk<CR>", desc = "prev hunk in buffer", mode = {"n", "v"}},
            {"<leader>P", "<cmd>Gitsigns preview_hunk_inline<CR>", desc = "preview current hunk inline"},
            {"<leader>R", "<cmd>Gitsigns reset_hunk<CR>", desc = "reset current hunk"},
            {"<leader>R", ":'<,'>Gitsigns reset_hunk<CR>", desc = "reset current hunk (visual mode)", mode = "v"},
            {"<leader>S", "<cmd>Gitsigns stage_hunk<CR>", desc = "stage current hunk"},
            {"<leader>S", ":'<,'>Gitsigns stage_hunk<CR>", desc = "stage current hunk (visual mode)", mode = "v"},
            {"<leader>U", "<cmd>Gitsigns undo_stage_hunk<CR>", desc = "unstage current hunk"},
            {"<leader>U", ":'<,'>Gitsigns undo_stage_hunk<CR>", desc = "unstage current hunk (visual mode)", mode = "v"},
        },
        event = {"BufReadPre", "BufNewFile"},
    },
    {
        'kdheepak/lazygit.nvim',
        keys = {
            {"<leader>gg", "<cmd>LazyGit<CR>", desc = "open lazygit"},
            {"<leader>gO", "<cmd>LazyGitConfig<CR>", desc = "open lazygit config"},
            {"<leader>gl", "<cmd>LazyGitFilterCurrentFile<CR>", desc = "open git log in lazygit"},
        },
        lazy = true,
        config = function ()
            local g_opts = {
                lazygit_config_file_path = '~/.config/lazygit/config.yml',
                lazygit_floating_window_use_plenary = 0,
                lazygit_floating_window_winblend = 0,
                lazygit_use_custom_config_file_path = 1,
            }
            for k, v in pairs(g_opts) do
                vim.g[k] = v
            end
        end
    },
    {
        'tpope/vim-fugitive',
        dependencies = {
            'tommcdo/vim-fubitive',
            'tpope/vim-rhubarb',
        },
        keys = {
            {"<leader>G", "<cmd>Git<CR>", desc = "open fugitive"},
            {"<leader>gn", ":Git checkout -b ", desc = "checkout new branch"},
            {"<leader>gc", "<cmd>Git commit<CR>", desc = "commit using fugitive"},
        },
        cmd = "Git",
        lazy = true,
    },
    {
        'sindrets/diffview.nvim',
        keys = {
            {"<leader>dvh", "<cmd>DiffviewOpen HEAD~1<CR>", desc = "dif HEAD with HEAD~1"},
            {"<leader>dvH", ":DiffviewOpen HEAD~", desc = "diff HEAD with HEAD~n"},
            {"<leader>dvl", "<cmd>DiffviewFileHistory<CR>", desc = "git log in diff window"},
            {"<leader>dvo", "<cmd>DiffviewOpen<CR>", desc = "open Diffview"},
        },
        lazy = true,
    },
    {
        'rhysd/git-messenger.vim',
        keys = {
            {"<leader>gm", "<cmd>GitMessenger<CR>", desc = "open git commit message"},
        },
        lazy = true,
        config = function()
            local g_opts = {
                git_messenger_always_into_popup = true,
                git_messenger_floating_win_opts = {border = 'single', width = 70},
                git_messenger_popup_content_margins = false,
            }
            for k, v in pairs(g_opts) do
                vim.g[k] = v
            end
        end
    },
    {
        'ThePrimeagen/git-worktree.nvim',
        keys = {
            {
                "<leader>gws",
                function()
                    local cmd_to_table = require("utils").cmd_to_table
                    local root = string.gsub(vim.fn.system('git worktree list --porcelain | head -1 | cut -d" " -f2'),
                    "[\n\r]", "")
                    if root == nil then
                        print("error getting bare repo root!")
                        return
                    end
                    local branches = cmd_to_table("git branch -a")
                    if rawequal(next(branches), nil) then
                        print("no branches!")
                        return
                    end
                    vim.ui.select(branches, {prompt = "select branch"}, function(branch)
                        local path = vim.fn.input({prompt = "Enter worktree path from bare root: ", default = ""})
                        if path == "" then return end
                        local full_path = root .. "/" .. path
                        vim.fn.system("git worktree add " .. full_path .. " " .. branch)
                        require("git-worktree").switch_worktree(full_path)
                    end)
                end, desc = "checkout existing branch as a new worktree"
            }
        },
        config = function ()
            local worktree = require("git-worktree")
            worktree.setup({
                change_directory_command = "cd", -- default: "cd",
                update_on_change = true, -- default: true,
                update_on_change_command = "e .", -- default: "e .",
                clearjumps_on_change = true, -- default: true,
                autopush = false -- default: false,
            })
            worktree.on_tree_change(function()
                -- todo: handle open term buffers when switching
                local branch_name = vim.fn.system("!git rev-parse --abbrev-ref head")
                vim.cmd.clearjumps()
                local bufs = vim.api.nvim_list_bufs()
                local bufnr = vim.api.nvim_get_current_buf()
                for _, buf in ipairs(bufs) do
                    if vim.api.nvim_buf_is_loaded(buf) and buf ~= bufnr then
                        local buf_name = vim.api.nvim_buf_get_name(buf)
                        if not string.find(buf_name, branch_name) then
                            vim.api.nvim_buf_delete(buf, {})
                        end
                    end
                end
                if vim.api.nvim_buf_get_name(bufnr) ~= "" then vim.cmd [[ e ]] end
            end)
        end
    },
}
