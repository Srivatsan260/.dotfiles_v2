return {
    "dotsilas/darcubox-nvim",
    name = "darcubox",
    event = "ColorSchemePre",
    init = function()
        local opts = {
            options = {
                transparent = true,
                styles = {
                    comments = {},
                    functions = {},
                    keywords = {},
                    types = {},
                },
            },
        }
        require("darcubox").setup(opts)
    end
}
