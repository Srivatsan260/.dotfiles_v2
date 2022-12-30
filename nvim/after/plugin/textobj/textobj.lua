local t_ok, textobjs = pcall(require, "various-textobjs")
if not t_ok then return end

textobjs.setup {
    lookForwardLines = 0, -- default: 5. Set to 0 to only look in the current line
    useDefaultKeymaps = false -- Use suggested keymaps (see README). Default: false.
}
