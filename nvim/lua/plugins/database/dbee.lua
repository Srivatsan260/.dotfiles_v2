return {
    "kndndrj/nvim-dbee",
    dependencies = {
        "MunifTanjim/nui.nvim",
    },
    keys = { {"<leader>DB", function() require("dbee").toggle() end, desc = "Open the DADBOD UI"} },
    build = function()
        -- Install tries to automatically detect the install method.
        -- if it fails, try calling it with one of these parameters:
        --    "curl", "wget", "bitsadmin", "go"
        require("dbee").install()
    end,
    config = function()
        require("dbee").setup({
            sources = {
                require("dbee.sources").EnvSource:new("DBEE_CONNECTIONS"),
            },
        })
    end,
}
