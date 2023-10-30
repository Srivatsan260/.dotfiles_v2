function SetPythonPath(path)
    local clients = vim.lsp.get_active_clients({
        bufnr = vim.api.nvim_get_current_buf(),
        name = "pyright",
    })
    for _, client in ipairs(clients) do
        for _, setting in ipairs(client.config.settings) do
            print(setting)
        end
        client.config.settings = vim.tbl_deep_extend(
            "force",
            client.config.settings,
            { python = { pythonPath = os.getenv("PYTHONPATH") .. ":" .. path } }
        )
        client.notify("workspace/didChangeConfiguration", { settings = nil })
    end
end
vim.keymap.set("n", "<leader>spp", function()
    vim.ui.input({ prompt = "python path: " }, function(path)
        SetPythonPath(path)
    end)
end)
