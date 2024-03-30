return {
    "chrisgrieser/nvim-genghis",
    lazy = true,
    dependencies = "stevearc/dressing.nvim",
    cmd = {
        "Chmodx",
        "CopyDirectoryPath",
        "CopyFilename",
        "CopyFilepath",
        "CopyFilepathWithTilde",
        "CopyRelativeDirectoryPath",
        "CopyRelativePath",
        "Duplicate",
        "Move",
        "MoveToFolderInCwd",
        "New",
        "NewFromSelection",
        "Rename",
        "Trash",
    },
    init = function ()
        vim.g.genghis_use_systemclipboard = true
    end
}
