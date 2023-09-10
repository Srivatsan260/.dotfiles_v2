return {
    {
        "kevinhwang91/nvim-bqf",
        enabled = false,
        ft = "qf",
        opts = {
            auto_enable = true,
            magic_window = true,
            auto_resize_height = false,
            preview = {
                auto_preview = true,
                border_chars = { "│", "│", "─", "─", "╭", "╮", "╰", "╯", "█" },
                show_title = true,
                delay_syntax = 50,
                win_height = 25,
                win_vheight = 15,
                wrap = false,
                buf_label = true,
            },
            filter = {
                fzf = {
                    action_for = {
                        ["ctrl-t"] = "tabedit",
                        ["ctrl-v"] = "vsplit",
                        ["ctrl-x"] = "split",
                        ["ctrl-q"] = "signtoggle",
                        ["ctrl-c"] = "closeall",
                    },
                    extra_opts = { "--bind", "ctrl-o:toggle-all" },
                },
            },
        },
    },
}
