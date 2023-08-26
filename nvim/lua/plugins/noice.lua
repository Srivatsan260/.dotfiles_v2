return {
    "folke/noice.nvim",
    enabled = false,
    dependencies = {
        "MunifTanjim/nui.nvim",
    },
    event = "VeryLazy",
    opts = {
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
            },
            hover = {
                enabled = false,
            },
            signature = {
                enabled = false,
            },
        },
        presets = {
            bottom_search = false,
            command_palette = true,
            long_message_to_split = true,
        },
    },
    -- stylua: ignore
    keys = {
        { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
        { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
        { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
        {
            "<c-f>",
            function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end,
            silent = true,
            expr = true,
            desc = "Scroll forward",
            mode = {"i", "n", "s"}
        },
        {
            "<c-b>",
            function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end,
            silent = true,
            expr = true,
            desc = "Scroll backward",
            mode = {"i", "n", "s"}
        },
    },
}
