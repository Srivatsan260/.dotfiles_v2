local lsp_ok, lsp = pcall(require, "lsp-zero")

-- neovim code helper
local neodev_ok, neodev = pcall(require, "neodev")
if neodev_ok then require('neodev').setup {} end

if not lsp_ok then return end

lsp.preset('recommended')
lsp.ensure_installed({
    'pyright', 'tsserver', 'html', 'cssls', 'emmet_ls', 'rust_analyzer', 'sumneko_lua'
})

lsp.set_preferences({
    set_lsp_keymaps = false,
    manage_nvim_cmp = false,
    sign_icons = {error = 'E', warn = 'W', hint = 'H', info = 'I'}
})

lsp.configure('sumneko_lua', {
    settings = {
        Lua = {
            workspace = {library = vim.api.nvim_get_runtime_file("", true)},
            diagnostics = {globals = {'vim', 'use'}},
            telemetry = {enable = false},
            completion = {callSnippet = 'Replace'}
        }
    }

})

lsp.on_attach(function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local bufopts = {noremap = true, silent = true, buffer = bufnr}
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references theme=ivy<CR>', bufopts)
    vim.keymap.set('n', '<leader>g,', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<leader>gt', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>ds', vim.lsp.buf.document_symbol, bufopts)
    vim.keymap.set('n', '<leader>dS', vim.lsp.buf.workspace_symbol, bufopts)
    vim.keymap.set('n', '<leader>ac', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    if vim.bo.filetype == 'python' then
        vim.keymap.set('n', '<leader>-', '<cmd>!isort %<CR>', bufopts)
    elseif vim.bo.filetype == 'lua' then
        vim.keymap.set('n', '<leader>=', '<cmd>call LuaFormat()<CR>', bufopts)
    else
        vim.keymap.set('n', '<leader>=', vim.lsp.buf.format, bufopts)
    end
    vim.keymap.set('n', '<leader>ai', vim.lsp.buf.incoming_calls, bufopts)
    vim.keymap.set('n', '<leader>ao', vim.lsp.buf.outgoing_calls, bufopts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>sc', function()
        print(vim.inspect(vim.lsp.get_active_clients()[1].server_capabilities))
    end, bufopts)
    vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    update_in_insert = false,
    underline = false,
    severity_sort = true,
    float = true
})
