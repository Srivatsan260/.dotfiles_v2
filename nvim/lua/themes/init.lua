local M = {}

M.themes = {}
local f = io.popen("ls nvim/lua/themes/")
if f then
    for name in f:lines() do
        if name ~= "init.lua" then
            local value = string.gsub(name, ".lua", "")
            M.themes[value] = value
        end
    end
end

return M
