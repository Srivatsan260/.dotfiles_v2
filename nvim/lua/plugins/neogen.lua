return {
    {
        "danymat/neogen",
        opts = {
            enabled = true,
            languages = {
                python = { template = { annotation_convention = "google_docstrings" } },
                rust = { template = { annotation_convention = "rustdoc" } },
            },
        },
        lazy = true,
        keys = {
            { "<leader>ngc", "<cmd>Neogen class<CR>", desc = "generate docstring for class" },
            { "<leader>ngf", "<cmd>Neogen func<CR>", desc = "generate docstring for function" },
            { "<leader>ngt", "<cmd>Neogen type<CR>", desc = "generate docstring for type" },
        },
    },
}
