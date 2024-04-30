local M = {}

---@param cmd string
---@return table
M.cmd_to_table = function(cmd)
    local t = {}
    local f = io.popen(cmd)
    if f then
        local idx = 1
        for line in f:lines() do
            t[idx] = line
            idx = idx + 1
        end
    end
    return t
end

---@param cmd_or_prefix string
---@param prompt string
---@param opts table
---@return function
M.vimux_run_cmd = function(cmd_or_prefix, prompt, opts)
    return function()
        print(cmd_or_prefix)
        if not opts then
            if not prompt then
                vim.cmd("VimuxRunCommand('" .. cmd_or_prefix .. "')")
            else
                vim.ui.input({ prompt = prompt }, function(input)
                    vim.cmd("VimuxRunCommand('" .. cmd_or_prefix .. " " .. input .. "')")
                end)
            end
        else
            vim.ui.select(opts, { prompt = prompt }, function(choice)
                vim.cmd("VimuxRunCommand('" .. cmd_or_prefix .. " " .. choice .. "')")
            end)
        end
    end
end

---@param root string | nil
---@param op string | table
---@return nil
M.async_git_op = function(op, root)
    local cmd = nil
    if root == nil then
        root = "./"
    end
    if type(op) == "string" then
        cmd = "AsyncRun -cwd=" .. root .. " git " .. op
    else
        cmd = "AsyncRun -cwd=" .. root .. " git " .. table.concat(op, " ")
    end
    vim.cmd(cmd)
    vim.cmd.copen()
end

return M
