local M = {}

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

return M
