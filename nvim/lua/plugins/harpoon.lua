return {
    'ThePrimeagen/harpoon',
    opts = {menu = {width = math.floor(vim.api.nvim_win_get_width(0) / 2)}},
    keys = {
        {"<leader>H", function() require('harpoon.ui').toggle_quick_menu() end, desc = "open Harpoon"},
        {"<leader>;", function() require('harpoon.mark').add_file() end, desc = "set harpoon mark"},
        {"<leader>1", function() require("harpoon.ui").nav_file(1) end, desc = "goto harpoon 1"},
        {"<leader>2", function() require("harpoon.ui").nav_file(2) end, desc = "goto harpoon 2"},
        {"<leader>3", function() require("harpoon.ui").nav_file(3) end, desc = "goto harpoon 3"},
        {"<leader>4", function() require("harpoon.ui").nav_file(4) end, desc = "goto harpoon 4"},
        {"<leader>5", function() require("harpoon.ui").nav_file(5) end, desc = "goto harpoon 5"},
        {"<leader>6", function() require("harpoon.ui").nav_file(6) end, desc = "goto harpoon 6"},
        {"<leader>7", function() require("harpoon.ui").nav_file(7) end, desc = "goto harpoon 7"},
        {"<leader>8", function() require("harpoon.ui").nav_file(8) end, desc = "goto harpoon 8"},
        {"<leader>9", function() require("harpoon.ui").nav_file(9) end, desc = "goto harpoon 9"},
    },
    lazy = true
}
