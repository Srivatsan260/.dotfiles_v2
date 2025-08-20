-- TODO: remove this if not needed / doesn't work

---@param path string
---@return nil
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
-- vim.keymap.set("n", "<leader>spp", function()
--     vim.ui.input({ prompt = "python path: " }, function(path)
--         if path == nil then
--             return
--         end
--         SetPythonPath(path)
--     end)
-- end)

vim.api.nvim_create_user_command("DbtRun", function()
    if vim.fn.glob("dbt_project.yml") == "" then
        error("dbt_project.yml not found!")
        return
    end
    local models = { "all" }
    for line in io.popen("dbt ls --resource-type model --output name --log-level none"):lines() do
        table.insert(models, line)
    end
    vim.ui.select(models, { prompt = "select model" }, function(selection)
        if selection == nil then
            return
        end
        if selection == "all" then
            vim.cmd("AsyncRun dbt run")
        else
            vim.cmd("AsyncRun dbt run --models " .. selection)
        end
    end)
end, {})

-- TODO: finish writing this in lua
vim.cmd(
    [[ command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor ]]
)

-- vim.api.nvim_create_user_command(
--     "WipeReg",
--     function()
--         for i=34,122 do
--             print(i)
--             vim.fn.setreg(vim.fn.nr2char(i), {})
--         end
--     end,
--     {silent = true}
-- )
