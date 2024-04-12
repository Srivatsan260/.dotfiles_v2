return {
    "chrisgrieser/nvim-various-textobjs",
    -- TODO: fix lazy load issue
    lazy = false,
    opts = {
        lookForwardLines = 5, -- default: 5. Set to 0 to only look in the current line
        useDefaultKeymaps = false, -- Use suggested keymaps (see README). Default: false.
    },
    keys = {
        {
            "iS",
            function()
                require("various-textobjs").subword(true)
            end,
            desc = "visual select in subword",
            mode = { "o", "x" },
        },
        {
            "aS",
            function()
                require("various-textobjs").subword(false)
            end,
            desc = "visual select around subword",
            mode = { "o", "x" },
        },
        {
            "iv",
            function()
                require("various-textobjs").value(true)
            end,
            desc = "visual select in value",
            mode = { "o", "x" },
        },
        {
            "av",
            function()
                require("various-textobjs").value(false)
            end,
            desc = "visual select around value",
            mode = { "o", "x" },
        },
        {
            "in",
            function()
                require("various-textobjs").number(true)
            end,
            desc = "visual select in number",
            mode = { "o", "x" },
        },
        {
            "an",
            function()
                require("various-textobjs").number(false)
            end,
            desc = "visual select around number",
            mode = { "o", "x" },
        },
        {
            "ii",
            function()
                require("various-textobjs").indentation(true, true)
            end,
            desc = "visual select in indent",
            mode = { "o", "x" },
        },
        {
            "ai",
            function()
                require("various-textobjs").indentation(false, false)
            end,
            desc = "visual select around indent",
            mode = { "o", "x" },
        },
    },
}
