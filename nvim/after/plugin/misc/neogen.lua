require('neogen').setup({
    enabled = true,
    languages = {
        python = {template = {annotation_convention = 'google_docstrings'}},
        rust = {template = {annotation_convention = 'rustdoc'}}
    }
    -- snippet_engine = 'luasnip'
})
