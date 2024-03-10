return {
    "rhysd/git-messenger.vim",
    keys = {
        { "<leader>gm", "<cmd>GitMessenger<CR>", desc = "open git commit message" },
    },
    lazy = true,
    config = function()
        local g_opts = {
            git_messenger_always_into_popup = true,
            git_messenger_floating_win_opts = { border = "single", width = 70 },
            git_messenger_popup_content_margins = false,
        }
        for k, v in pairs(g_opts) do
            vim.g[k] = v
        end
    end,
}
