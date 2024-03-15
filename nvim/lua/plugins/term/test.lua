return {
    "vim-test/vim-test",
    dependencies = { "preservim/vimux" },
    keys = {
        { "<leader>tsn", "<cmd>TestNearest<CR>", desc = "test nearest" },
        { "<leader>tsc", "<cmd>TestClass<CR>", desc = "test class" },
        { "<leader>tsf", "<cmd>TestFile<CR>", desc = "test file" },
    },
    cmd = { "TestNearest", "TestFile", "TestClass" },
    lazy = true,
    config = function()
        vim.g["test#strategy"] = "vimux"
    end,
}
