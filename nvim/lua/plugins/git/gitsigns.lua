return {
    "lewis6991/gitsigns.nvim",
    opts = {
        signs = {
            add = {
                hl = "GitSignsAdd",
                text = "│",
                numhl = "GitSignsAddNr",
                linehl = "GitSignsAddLn",
            },
            change = {
                hl = "GitSignsChange",
                text = "│",
                numhl = "GitSignsChangeNr",
                linehl = "GitSignsChangeLn",
            },
            delete = {
                hl = "GitSignsDelete",
                text = "_",
                numhl = "GitSignsDeleteNr",
                linehl = "GitSignsDeleteLn",
            },
            topdelete = {
                hl = "GitSignsDelete",
                text = "‾",
                numhl = "GitSignsDeleteNr",
                linehl = "GitSignsDeleteLn",
            },
            changedelete = {
                hl = "GitSignsChange",
                text = "~",
                numhl = "GitSignsChangeNr",
                linehl = "GitSignsChangeLn",
            },
            untracked = {
                hl = "GitSignsAdd",
                text = "┆",
                numhl = "GitSignsAddNr",
                linehl = "GitSignsAddLn",
            },
        },
        signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
        numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
        linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = { interval = 1000, follow_files = true },
        attach_to_untracked = true,
        current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
            delay = 250,
            ignore_whitespace = false,
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
        yadm = { enable = false },
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
            "<cmd>Gitsigns preview_hunk_inline<CR>",
            desc = "preview current hunk inline",
        },
        {
            "<leader>R",
            ":Gitsigns reset_hunk<CR>",
            desc = "reset current hunk",
            mode = { "n", "x" },
        },
        {
            "<leader>S",
            ":Gitsigns stage_hunk<CR>",
            desc = "stage current hunk",
            mode = { "n", "x" },
        },
        {
            "<leader>U",
            ":Gitsigns undo_stage_hunk<CR>",
            desc = "unstage current hunk",
            mode = { "n", "x" },
        },
    },
    event = { "BufReadPre", "BufNewFile" },
}
