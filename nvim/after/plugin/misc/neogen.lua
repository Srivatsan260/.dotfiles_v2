local n_ok, neogen = pcall(require, "neogen")
if not n_ok then return end

neogen.setup({
    enabled = true,
    languages = {
        python = {template = {annotation_convention = 'google_docstrings'}},
        rust = {template = {annotation_convention = 'rustdoc'}}
    }
    -- snippet_engine = 'luasnip'
})
