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
vim.keymap.set("n", "<leader>spp", function()
    vim.ui.input({ prompt = "python path: " }, function(path)
        if path == nil then
            return
        end
        SetPythonPath(path)
    end)
end)

-- TODO: finish writing this in lua
vim.cmd([[ command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor ]])

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

-- Generates ctags for dbt projects
---@return nil
local function DbtCtags()
    if vim.fn.glob("dbt_project.yml") == "" then
        error("Could not find dbt_project.yml!")
        return
    end

    local ctags = io.open("tags", "w+")

    if not ctags then
        error("Could not open tags file!")
        return
    end

    io.output(ctags)

    local f = io.popen("find ./models/ -type f")
    if f then
        for file in f:lines() do
            local basename = file:match("[^/]+$")
            local ext = file:match("[^.]+$")
            if ext == "sql" then
                io.write(basename .. "\t" .. file .. "\t" .. "1;\tv\n")
            end
        end
    end

    io.close(ctags)
end

vim.api.nvim_create_user_command("DbtCtags", DbtCtags, {})
