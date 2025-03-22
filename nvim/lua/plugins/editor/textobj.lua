return {
    "chrisgrieser/nvim-various-textobjs",
    -- TODO: fix lazy load issue
    opts = {
        lookForwardLines = 5, -- default: 5. Set to 0 to only look in the current line
        keymaps = {
            useDefaults = false,
        }
    },
    keys = {
        {
            "iS",
            function()
                require("various-textobjs").subword("inner")
            end,
            desc = "visual select in subword",
            mode = { "o", "x" },
        },
        {
            "aS",
            function()
                require("various-textobjs").subword("outer")
            end,
            desc = "visual select around subword",
            mode = { "o", "x" },
        },
        {
            "iv",
            function()
                require("various-textobjs").value("inner")
            end,
            desc = "visual select in value",
            mode = { "o", "x" },
        },
        {
            "av",
            function()
                require("various-textobjs").value("outer")
            end,
            desc = "visual select around value",
            mode = { "o", "x" },
        },
        {
            "in",
            function()
                require("various-textobjs").number("inner")
            end,
            desc = "visual select in number",
            mode = { "o", "x" },
        },
        {
            "an",
            function()
                require("various-textobjs").number("outer")
            end,
            desc = "visual select around number",
            mode = { "o", "x" },
        },
        {
            "ii",
            function()
                require("various-textobjs").indentation("inner", "inner")
            end,
            desc = "visual select in indent",
            mode = { "o", "x" },
        },
        {
            "ai",
            function()
                require("various-textobjs").indentation("outer", "outer")
            end,
            desc = "visual select around indent",
            mode = { "o", "x" },
        },
    },
}
