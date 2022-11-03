local function git_branch()
    local process = io.popen("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'", 'r')
    local lastline
    if process ~= nil then
        for line in process:lines() do
            lastline = line
        end
        return lastline
    end
    return ''
end

local statusline = '%{mode()}' -- mode
local branch = git_branch()
if branch ~= nil then
    statusline = statusline .. '   ' .. branch
end
statusline = statusline .. '  ' .. '%f' -- file name
statusline = statusline .. '%='
statusline = statusline .. '  ' .. '%y' -- file name
statusline = statusline .. '  ' .. '%{&fileencoding?&fileencoding:&encoding}' -- file type
statusline = statusline .. '  ' .. '[%{&fileformat}]' -- file type

vim.opt.statusline = statusline
