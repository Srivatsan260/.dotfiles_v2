return {
    "ray-x/lsp_signature.nvim",
    lazy = true,
    keys = {
        { "<C-s>", function() require("lsp_signature").toggle_float_win() end, desc = "toggle signature", mode = "i" },
    }
}
