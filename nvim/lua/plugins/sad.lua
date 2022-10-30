require('sad').setup({
    diff = 'delta', -- you can use `diff`, `diff-so-fancy`
    ls_file = 'fd', -- also git ls_file
    exact = false, -- exact match
    vsplit = false, -- split sad window the screen vertically, when set to number
    -- it is a threadhold when window is larger than the threshold sad will split vertically,
    height_ratio = 1, -- height ratio of sad window when split horizontally
    width_ratio = 1, -- height ratio of sad window when split vertically
})
