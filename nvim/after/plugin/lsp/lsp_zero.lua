local lsp_ok, lsp = pcall(require, "lsp-zero")

-- neovim code helper
local neodev_ok, neodev = pcall(require, "neodev")
if neodev_ok then neodev.setup {} end

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

    local bufopts = function (desc)
        return {noremap = true, silent = true, buffer = bufnr, desc = desc}
    end
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts("goto declaration"))
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts("goto definition"))
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts("help"))
    vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<CR>', bufopts("find lsp references"))
    vim.keymap.set('n', '<leader>g,', vim.lsp.buf.signature_help, bufopts("signature help"))
    vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, bufopts("goto implementation"))
    vim.keymap.set('n', '<leader>gt', vim.lsp.buf.type_definition, bufopts("goto type definition"))
    vim.keymap.set('n', '<leader>ds', vim.lsp.buf.document_symbol, bufopts("list document lsp symbols"))
    vim.keymap.set('n', '<leader>dS', vim.lsp.buf.workspace_symbol, bufopts("list workspace lsp symbols"))
    vim.keymap.set('n', '<leader>ac', vim.lsp.buf.code_action, bufopts("code actions"))
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts("rename current symbol"))
    if vim.bo.filetype == 'python' then
        vim.keymap.set('n', '<leader>-', '<cmd>!isort %<CR>', bufopts("isort"))
    elseif vim.bo.filetype == 'lua' then
        vim.keymap.set('n', '<leader>=', '<cmd>call LuaFormat()<CR>', bufopts("luaformat"))
    else
        vim.keymap.set('n', '<leader>=', vim.lsp.buf.format, bufopts("format document"))
    end
    vim.keymap.set('n', '<leader>ai', vim.lsp.buf.incoming_calls, bufopts("list incoming calls"))
    vim.keymap.set('n', '<leader>ao', vim.lsp.buf.outgoing_calls, bufopts("list outgoing calls"))
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts("add workspace folder"))
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts("remove workspace folder"))
    vim.keymap.set('n', '<leader>sc', function()
        print(vim.inspect(vim.lsp.get_active_clients()[1].server_capabilities))
    end, bufopts("list lsp server capabilities"))
    vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts("list workspace folders"))
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
