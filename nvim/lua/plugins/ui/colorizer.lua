return {
    "norcalli/nvim-colorizer.lua",
    opts = {
        css = { hsl_fn = true, rgb_fn = true, names = true },
        "javascript",
        html = { mode = "foreground" },
        "*",
    },
    event = { "BufReadPost", "BufNewFile" },
}
