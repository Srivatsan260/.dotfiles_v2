local ok, M = pcall(require, "various-textobjs")
if not ok then return end

M.setup {
    lookForwardLines = 0, -- default: 5. Set to 0 to only look in the current line
    useDefaultKeymaps = false -- Use suggested keymaps (see README). Default: false.
}
