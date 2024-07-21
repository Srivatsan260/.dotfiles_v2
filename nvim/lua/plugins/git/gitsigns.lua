return {
    "lewis6991/gitsigns.nvim",
    opts = {
        signs = {
            add          = { text = '┃' },
            change       = { text = '┃' },
            delete       = { text = '_' },
            topdelete    = { text = '‾' },
            changedelete = { text = '~' },
            untracked    = { text = '┆' },
        },
        signs_staged = {
            add          = { text = '┃' },
            change       = { text = '┃' },
            delete       = { text = '_' },
            topdelete    = { text = '‾' },
            changedelete = { text = '~' },
            untracked    = { text = '┆' },
        },
        signs_staged_enable = true,
        signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
        numhl      = true, -- Toggle with `:Gitsigns toggle_numhl`
        linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = {
            follow_files = true,
            interval = 1000
        },
        auto_attach = true,
        attach_to_untracked = false,
        current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
            delay = 250,
            ignore_whitespace = false,
            virt_text_priority = 100,
        },
        current_line_blame_formatter = "  <author>, <author_time:%Y-%m-%d> - <summary>",
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        max_file_length = 40000, -- Disable if file is longer than this (in lines)
        preview_config = {
            -- Options passed to nvim_open_win
            border = "single",
            style = "minimal",
            relative = "cursor",
            row = 0,
            col = 1,
        },
    },
    keys = {
        {
            "]g",
            "<cmd>Gitsigns next_hunk<CR>",
            desc = "next hunk in buffer",
            mode = { "n", "v" },
        },
        {
            "[g",
            "<cmd>Gitsigns prev_hunk<CR>",
            desc = "prev hunk in buffer",
            mode = { "n", "v" },
        },
        {
            "<leader>H",
            "<cmd>Gitsigns preview_hunk<CR>",
            desc = "preview current hunk",
        },
        {
            "<leader>R",
            function() require("gitsigns").reset_hunk() end,
            desc = "reset current hunk",
        },
        {
            "<leader>R",
            function()
                require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end,
            desc = "reset current hunk",
            mode = { "v" },
        },
        {
            "<leader>S",
            function() require("gitsigns").stage_hunk() end,
            desc = "stage current hunk",
        },
        {
            "<leader>S",
            function()
                require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end,
            desc = "stage current hunk",
            mode = { "v" },
        },
        {
            "<leader>U",
            function()
                require("gitsigns").undo_stage_hunk()
            end,
            desc = "unstage current hunk",
        },
        {
            "<leader>U",
            function()
                require("gitsigns").undo_stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end,
            desc = "unstage current hunk",
            mode = { "v" },
        },
        {
            "ih",
            ":<C-U>Gitsigns select_hunk<CR>",
            mode = { "o", "x" },
            desc = "select hunk textobject",
        }
    },
    event = { "BufReadPre", "BufNewFile" },
}
