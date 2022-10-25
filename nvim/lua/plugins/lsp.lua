local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
vim.keymap.set('n', '<leader>sc', '<cmd>lua print(vim.inspect(vim.lsp.buf_get_clients()[1].server_capabilities))<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
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
  vim.keymap.set('n', '<leader>ar', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>-', '<cmd>!isort %<CR>', bufopts)
  vim.keymap.set('n', '<leader>=', '<cmd>!black %<CR>', bufopts)
  vim.keymap.set('n', '<leader>ai', vim.lsp.buf.incoming_calls, bufopts)
  vim.keymap.set('n', '<leader>ao', vim.lsp.buf.outgoing_calls, bufopts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local lspconfig = require('lspconfig')

-- luasnip setup
local luasnip = require 'luasnip'

luasnip.config.set_config {
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true,
}

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-/>'] = cmp.mapping(cmp.mapping.complete({
        reason = cmp.ContextReason.Auto,
    }), {"i", "c"}),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<C-k>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<C-j>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'vim-dadbod-completion' },
    { name = 'conjure' },
  },
}

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

lspconfig['pyright'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities
}

lspconfig['tsserver'].setup {
    on_attach = on_attach,
    capabilities = capabilities,
}
capabilities.textDocument.completion.completionItem.snippetSupport = true
lspconfig['html'].setup {
    on_attach = on_attach,
    capabilities = capabilities,
}
lspconfig['cssls'].setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

local rt = require('rust-tools')

rt.setup {
    server = {
        on_attach = function(_, buffer)
            vim.keymap.set('n', 'K', rt.hover_actions.hover_actions, { buffer = buffer })
            vim.keymap.set('n', '<leader>a', rt.code_action_group.code_action_group, { buffer = buffer })
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
            vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references theme=dropdown<CR>', bufopts)
            vim.keymap.set('n', 'g,', vim.lsp.buf.signature_help, bufopts)
            vim.keymap.set('n', '<leader>=', vim.lsp.buf.format, bufopts)
        end,
    },
}

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

-- lua lsp setup
lspconfig.sumneko_lua.setup {
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
                path = runtime_path,
            },
            diagnostics = {
                globals = { 'vim', 'use' },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            }
        }
    }
}
