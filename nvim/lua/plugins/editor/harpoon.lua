return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    opts = {
        menu = {
            width = math.floor(vim.api.nvim_win_get_width(0) / 2)
        }
    },
    keys = {
        {
            "<leader><leader>h",
            function()
                local harpoon = require("harpoon")
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end,
            desc = "open Harpoon",
        },
        {
            "<leader>;",
            function()
                require("harpoon"):list():add()
            end,
            desc = "set harpoon mark",
        },
        {
            "<leader>1",
            function()
                require("harpoon"):list():select(1)
            end,
            desc = "goto harpoon 1",
        },
        {
            "<leader>2",
            function()
                require("harpoon"):list():select(2)
            end,
            desc = "goto harpoon 2",
        },
        {
            "<leader>3",
            function()
                require("harpoon"):list():select(3)
            end,
            desc = "goto harpoon 3",
        },
        {
            "<leader>4",
            function()
                require("harpoon"):list():select(4)
            end,
            desc = "goto harpoon 4",
        },
        {
            "<leader>5",
            function()
                require("harpoon"):list():select(5)
            end,
            desc = "goto harpoon 5",
        },
        {
            "<leader>6",
            function()
                require("harpoon"):list():select(6)
            end,
            desc = "goto harpoon 6",
        },
        {
            "<leader>7",
            function()
                require("harpoon"):list():select(7)
            end,
            desc = "goto harpoon 7",
        },
        {
            "<leader>8",
            function()
                require("harpoon"):list():select(8)
            end,
            desc = "goto harpoon 8",
        },
        {
            "<leader>9",
            function()
                require("harpoon"):list():select(9)
            end,
            desc = "goto harpoon 9",
        },
    },
    lazy = true,
}
