return {
    "ellisonleao/carbon-now.nvim",
    lazy = true,
    opts = {
        base_url = "https://carbon.now.sh/",
        open_cmd = "open",
        options = {
            theme = "monokai",
            window_theme = "none",
            font_family = "Hack",
            font_size = "18px",
            bg = "gray",
            line_numbers = true,
            line_height = "133%",
            drop_shadow = false,
            drop_shadow_offset_y = "20px",
            drop_shadow_blur = "68px",
            width = "1080",
            watermark = false,
        },
    },
    keys = {
        { "<leader>cr", ":CarbonNow<CR>", desc = "Carbon Now", mode = { "n", "x" } },
    },
}
