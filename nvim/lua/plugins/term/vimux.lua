return {
    "preservim/vimux",
    lazy = true,
    cmd = { "VimuxRunCommand", "VimuxRunLastCommand" },
    keys = {
        { "<leader>vml", "<cmd>VimuxRunLastCommand<CR>", desc = "run last command" },
        { "<leader>vmo", "<cmd>VimuxOpenRunner<CR>", desc = "open vimux runner" },
        { "<leader>vmt", "<cmd>VimuxTogglePane<CR>", desc = "toggle vimux pane" },
    },
}
