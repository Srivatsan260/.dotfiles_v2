return {
    'chrisgrieser/nvim-various-textobjs',
    lazy = true,
    opts = {
        lookForwardLines = 5, -- default: 5. Set to 0 to only look in the current line
        useDefaultKeymaps = false -- Use suggested keymaps (see README). Default: false.
    },
    keys = {
        {"iS", function() require("various-textobjs").subword(true) end, desc = "visual select in subword"},
        {"aS", function() require("various-textobjs").subword(false) end, desc = "visual select around subword"},
        {"iv", function() require("various-textobjs").value(true) end, desc = "visual select in value"},
        {"av", function() require("various-textobjs").value(false) end, desc = "visual select around value"},
        {"in", function() require("various-textobjs").number(true) end, desc = "visual select in number"},
        {"an", function() require("various-textobjs").number(false) end, desc = "visual select around number"},
        {"ii", function() require("various-textobjs").indentation(true, true) end, desc = "visual select in indent"},
        {"ai", function() require("various-textobjs").indentation(false, false) end, desc = "visual select around indent"},
    }
}
