return {
    "kdheepak/lazygit.nvim",
    cmd = { "LazyGit", "LazyGitConfig", "LazyGitFilterCurrentFile" },
    keys = {
        { "<leader>gg", "<cmd>LazyGit<CR>", desc = "open lazygit" },
        { "<leader>gO", "<cmd>LazyGitConfig<CR>", desc = "open lazygit config" },
        { "<leader>gl", "<cmd>LazyGitFilterCurrentFile<CR>", desc = "open git log in lazygit" },
    },
    lazy = true,
    config = function()
        local home = os.getenv("HOME")
        local g_opts = {
            lazygit_config_file_path = {
                vim.fn.expand("~/.config/lazygit/config.yml"),
                vim.fn.expand("~/dotfiles/work_dots/lazygit/config.yml"),
            },
            lazygit_floating_window_use_plenary = 0,
            lazygit_floating_window_winblend = 0,
            lazygit_use_custom_config_file_path = 1,
        }
        for k, v in pairs(g_opts) do
            vim.g[k] = v
        end
    end,
}
