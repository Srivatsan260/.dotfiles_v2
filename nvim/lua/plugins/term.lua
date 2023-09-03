return {
    {
        "voldikss/vim-floaterm",
        dependencies = {
            {
                "voldikss/fzf-floaterm",
                dependencies = {
                    "junegunn/fzf.vim",
                    "junegunn/fzf",
                },
            },
        },
        lazy = true,
        keys = {
            {
                "<C-\\>",
                function()
                    return vim.bo.filetype ~= "lazygit" and "<cmd>FloatermToggle<CR>" or ""
                end,
                expr = true,
                desc = "toggle floaterm window",
                mode = { "n", "t" },
            },
            { "<leader>fl", "<cmd>Floaterms<CR>", desc = "list floaterms" },
            {
                "<leader>fn",
                ":FloatermNew --wintype=float --height=0.9 --width=0.9 ",
                desc = "new floaterm window with custom command",
            },
            {
                "<leader>fr",
                "<cmd>FloatermNew --wintype=float --height=0.9 --width=0.9 ranger<CR>",
                desc = "open ranger in a new floaterm window",
            },
            -- Floaterm window switching
            {
                "<C-h>",
                function()
                    return vim.bo.filetype == "floaterm" and "<C-\\><C-n><C-w>h" or "<C-h>"
                end,
                expr = true,
                desc = "window left (terminal mode)",
                mode = "t",
            },
            {
                "<C-j>",
                function()
                    return vim.bo.filetype == "floaterm" and "<C-\\><C-n><C-w>j" or "<C-j>"
                end,
                expr = true,
                desc = "window down (terminal mode)",
                mode = "t",
            },
            {
                "<C-k>",
                function()
                    return vim.bo.filetype == "floaterm" and "<C-\\><C-n><C-w>k" or "<C-k>"
                end,
                expr = true,
                desc = "window up (terminal mode)",
                mode = "t",
            },
            {
                "<C-l>",
                function()
                    return vim.bo.filetype == "floaterm" and "<C-\\><C-n><C-w>l" or "<C-l>"
                end,
                expr = true,
                desc = "window right (terminal mode)",
                mode = "t",
            },
        },
        config = function()
            local g_opts = {
                floaterm_autoclose = 0,
                floaterm_width = 0.5,
                floaterm_wintype = "vsplit",
            }
            for k, v in pairs(g_opts) do
                vim.g[k] = v
            end
        end,
    },
    {
        "aserowy/tmux.nvim",
        lazy = true,
        keys = { "<C-h>", "<C-j>", "<C-k>", "<C-l>" },
        opts = {
            copy_sync = {
                -- enables copy sync. by default, all registers are synchronized.
                -- to control which registers are synced, see the `sync_*` options.
                enable = true,

                -- ignore specific tmux buffers e.g. buffer0 = true to ignore the
                -- first buffer or named_buffer_name = true to ignore a named tmux
                -- buffer with name named_buffer_name
                ignore_buffers = { empty = false },

                -- TMUX >= 3.2: all yanks (and deletes) will get redirected to system
                -- clipboard by tmux
                redirect_to_clipboard = false,

                -- offset controls where register sync starts
                -- e.g. offset 2 lets registers 0 and 1 untouched
                register_offset = 0,

                -- overwrites vim.g.clipboard to redirect * and + to the system
                -- clipboard using tmux. If you sync your system clipboard without tmux,
                -- disable this option!
                sync_clipboard = false,

                -- synchronizes registers *, +, unnamed, and 0 till 9 with tmux buffers.
                sync_registers = false,

                -- syncs deletes with tmux clipboard as well, it is adviced to
                -- do so. Nvim does not allow syncing registers 0 and 1 without
                -- overwriting the unnamed register. Thus, ddp would not be possible.
                sync_deletes = true,

                -- syncs the unnamed register with the first buffer entry from tmux.
                sync_unnamed = true,
            },
            navigation = {
                -- cycles to opposite pane while navigating into the border
                cycle_navigation = true,

                -- enables default keybindings (C-hjkl) for normal mode
                enable_default_keybindings = true,

                -- prevents unzoom tmux when navigating beyond vim border
                persist_zoom = false,
            },
            resize = {
                -- enables default keybindings (A-hjkl) for normal mode
                enable_default_keybindings = true,

                -- sets resize steps for x axis
                resize_step_x = 1,

                -- sets resize steps for y axis
                resize_step_y = 1,
            },
        },
    },
    {
        "preservim/vimux",
        lazy = true,
        cmd = { "VimuxRunCommand", "VimuxRunLastCommand" },
        keys = {
            { "<leader>vml", "<cmd>VimuxRunLastCommand<CR>", desc = "run last command" },
            { "<leader>vmo", "<cmd>VimuxOpenRunner<CR>", desc = "open vimux runner" },
            { "<leader>vmt", "<cmd>VimuxTogglePane<CR>", desc = "toggle vimux pane" },
        },
    },
}
