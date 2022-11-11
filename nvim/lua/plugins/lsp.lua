local on_attach = function(_, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = {noremap = true, silent = true, buffer = bufnr}
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<CR>', bufopts)
    vim.keymap.set('n', 'g,', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', 'gw', vim.lsp.buf.document_symbol, bufopts)
    vim.keymap.set('n', 'gW', vim.lsp.buf.workspace_symbol, bufopts)
    vim.keymap.set('n', '<leader>fa', vim.lsp.buf.code_action, bufopts)
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
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder,
                   bufopts)
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, bufopts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, bufopts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, bufopts)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, bufopts)
    vim.keymap.set('n', '<leader>sc',
                   '<cmd>lua print(vim.inspect(vim.lsp.buf_get_clients()[1].server_capabilities))<CR>',
                   bufopts)
    vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

require('neodev').setup {} -- neovim code helper

local lspconfig = require('lspconfig')

local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150
}

local servers = {'pyright', 'tsserver', 'html', 'cssls', 'emmet_ls'}

capabilities.textDocument.completion.completionItem.snippetSupport = true
for _, server in pairs(servers) do
    lspconfig[server].setup {
        on_attach = on_attach,
        flags = lsp_flags,
        capabilities = capabilities
    }
end

-- lua lsp setup
lspconfig.sumneko_lua.setup {
    on_attach = on_attach,
    settings = {
        Lua = {
            workspace = {library = vim.api.nvim_get_runtime_file("", true)},
            diagnostics = {globals = {'vim', 'use'}},
            telemetry = {enable = false},
            completion = {callSnippet = 'Replace'}
        }
    }
}

-- rust lsp setup
local rt = require('rust-tools')

rt.setup {
    server = {
        on_attach = function(_, buffer)
            local bufopts = {noremap = true, silent = true, buffer = buffer}
            vim.keymap.set('n', 'K', rt.hover_actions.hover_actions,
                           {buffer = buffer})
            vim.keymap.set('n', '<leader>a',
                           rt.code_action_group.code_action_group,
                           {buffer = buffer})
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
            vim.keymap.set('n', 'gr',
                           '<cmd>Telescope lsp_references theme=dropdown<CR>',
                           bufopts)
            vim.keymap.set('n', 'g,', vim.lsp.buf.signature_help, bufopts)
            vim.keymap.set('n', '<leader>=', vim.lsp.buf.format, bufopts)
        end
    }
}
