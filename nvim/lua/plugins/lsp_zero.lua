local lsp = require('lsp-zero')

-- neovim code helper
require('neodev').setup {}

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
    vim.keymap.set('n', 'g,', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', 'gw', vim.lsp.buf.document_symbol, bufopts)
    vim.keymap.set('n', 'gW', vim.lsp.buf.workspace_symbol, bufopts)
    vim.keymap.set('n', '<leader>ac', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    if vim.bo.filetype == 'python' then
        vim.keymap.set('n', '<leader>-', '<cmd>!isort %<CR>', bufopts)
        vim.keymap.set('n', '<leader>=', '<cmd>!black %<CR>', bufopts)
    elseif vim.bo.filetype == 'lua' then
        vim.keymap.set('n', '<leader>=', '<cmd>call LuaFormat()<CR>', bufopts)
    else
        vim.keymap.set('n', '<leader>=', vim.lsp.buf.format, bufopts)
    end
    vim.keymap.set('n', '<leader>ai', vim.lsp.buf.incoming_calls, bufopts)
    vim.keymap.set('n', '<leader>ao', vim.lsp.buf.outgoing_calls, bufopts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, bufopts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, bufopts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, bufopts)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, bufopts)
    vim.keymap.set('n', '<leader>sc',
                   '<cmd>lua print(vim.inspect(vim.lsp.buf_get_clients()[1].server_capabilities))<CR>',
                   bufopts)
    vim.keymap.set('n', '<leader>wl',
                   function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, bufopts)
end)

vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        -- Enable underline, use default values
        underline = false,
        -- Enable virtual text, override spacing to 4
        virtual_text = {spacing = 4},
        -- Use a function to dynamically turn signs off
        -- and on, using buffer local variables
        signs = true
    })

lsp.setup()