local c_ok, coderunner = pcall(require, 'code_runner')
if not c_ok then return end

coderunner.setup({
    mode = 'term',
    focus = true,
    border = 'single',
    filetype = {python = "python -u"}
})
