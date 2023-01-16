local conceal = require("conceal")

-- should be run before .generate_conceals to use user Configuration
conceal.setup({
    --[[ ["language"] = {
        enabled = bool,
        ["keyword"] = {
            enabled     = bool,
            conceal     = string,
            highlight   = string
        }
    } ]]
    ["lua"] = {
        ["local"] = {
            enabled = true, -- to disable concealing for "local"
            conceal = "l",
        },
        ["return"] = {
            conceal = "R" -- to set the concealing to "R"
        },
        ["for"] = {
            highlight = "keyword" -- to set the Highlight group to "@keyword"
        }
    },
})

-- generate the scm queries
-- only need to be run when the Configuration changes
conceal.generate_conceals()
