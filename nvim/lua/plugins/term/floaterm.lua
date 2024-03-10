return {
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
}
