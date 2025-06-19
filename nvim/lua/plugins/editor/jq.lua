return {
    "yochem/jq-playground.nvim",
    cmd = { "JqPlayground" },
    output_window = {
        split_direction = "right",
        width = nil,
        height = nil,
        scratch = true,
        filetype = "json",
    },
    query_window = {
        split_direction = "below",
        width = nil,
        height = 0.3,
        scratch = false,
        filetype = "jq",
    },
    disable_default_keymap = false,
}
