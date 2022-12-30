local colorizer_ok, colorizer = pcall(require, "colorizer")
if not colorizer_ok then return end

colorizer.setup({
    css = {hsl_fn = true, rgb_fn = true, names = true},
    'javascript',
    html = {mode = 'foreground'},
    '*'
})
