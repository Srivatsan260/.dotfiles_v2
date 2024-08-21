return {
    "chrisgrieser/nvim-genghis",
    lazy = true,
    dependencies = "stevearc/dressing.nvim",
    cmd = {"Genghis"},
    init = function ()
        vim.g.genghis_use_systemclipboard = true
    end
}
