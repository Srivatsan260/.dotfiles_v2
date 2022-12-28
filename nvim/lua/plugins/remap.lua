-- TODO: move all plugin-specific remaps to after
-- TODO: add description for all remaps
vim.keymap.set("n", "K", function()
    local crates = require("crates")
    local filetype = vim.bo.filetype
    if vim.tbl_contains({'vim', 'help'}, filetype) then
        vim.cmd('h ' .. vim.fn.expand('<cword>'))
    elseif vim.tbl_contains({'man'}, filetype) then
        vim.cmd('Man ' .. vim.fn.expand('<cword>'))
    elseif vim.fn.expand('%:t') == 'Cargo.toml' and crates.popup_available() then
        crates.show_popup()
    else
        vim.lsp.buf.hover()
    end
end)

local config_path = vim.fn.stdpath("config")
vim.keymap.set("n", "<leader><leader>i", "<cmd> so " .. config_path .. "/lua/plugins/init.lua<CR>")
vim.keymap.set("n", "<leader><leader>r", "<cmd> so " .. config_path .. "/lua/plugins/remap.lua<CR>")
vim.keymap.set("n", "<leader><leader>s", "<cmd> so " .. config_path .. "/lua/plugins/set.lua<CR>")
vim.keymap.set("n", "<leader><leader>c",
    "<cmd> so " .. config_path .. "/after/plugin/color/color.lua<CR>")
vim.keymap.set("n", "<leader><leader>t",
    "<cmd> so " .. config_path .. "/after/plugin/treesitter.lua<CR>")
vim.keymap.set("n", "<leader><leader>l",
    "<cmd> so " .. config_path .. "/after/plugin/lsp/lsp_zero.lua<CR>")

-- copy file name to + register
vim.keymap.set("n", "<leader>cf", "<cmd>let @+=@%<CR>") -- absolute filepath
vim.keymap.set("n", "<leader>cF", "<cmd>let @+=expand('%:t')<CR>") -- filename

-- window switching
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- tab switching
vim.keymap.set("n", "<leader>tn", "<cmd>tabnew<CR>")
vim.keymap.set("n", "<leader>t.", "<cmd>tabnext<CR>")
vim.keymap.set("n", "<leader>t,", "<cmd>tabprev<CR>")
vim.keymap.set("n", "<leader>tc", "<cmd>tabclose<CR>")

-- netrw
vim.keymap.set("n", "<leader>,", "<cmd>Explore<CR>")

-- Floaterm
vim.keymap.set("n", "<C-\\>", "<cmd>FloatermToggle<CR>")
vim.keymap.set("n", "<leader>fl", "<cmd>Floaterms<CR>")
vim.keymap.set("n", "<leader>fn", ":FloatermNew --wintype=float --height=0.9 --width=0.9 ")
vim.keymap.set("n", "<leader>fr",
    "<cmd>FloatermNew --wintype=float --height=0.9 --width=0.9 ranger<CR>")
vim.keymap.set("t", "<localleader><Esc>", "<C-\\><C-n>")
vim.keymap.set("t", "<C-\\>", "<cmd>FloatermToggle<CR>")
-- Floaterm window switching
vim.keymap.set("t", "<C-h>", function()
    return vim.bo.filetype == "floaterm" and "<C-\\><C-n><C-w>h" or "<C-h>"
end, {expr = true})
vim.keymap.set("t", "<C-j>", function()
    return vim.bo.filetype == "floaterm" and "<C-\\><C-n><C-w>h" or "<C-j>"
end, {expr = true})
vim.keymap.set("t", "<C-k>", function()
    return vim.bo.filetype == "floaterm" and "<C-\\><C-n><C-w>h" or "<C-k>"
end, {expr = true})
vim.keymap.set("t", "<C-l>", function()
    return vim.bo.filetype == "floaterm" and "<C-\\><C-n><C-w>h" or "<C-l>"
end, {expr = true})

-- treesitter highlighting
vim.keymap.set("n", "<leader>th", "<cmd>TSBufToggle highlight<CR>")
vim.keymap.set("n", "<leader>tp", "<cmd>TSPlaygroundToggle<CR>")

vim.keymap.set("n", "<leader>tj", "<cmd>TSJToggle<CR>")

-- FZF / telescope / lazygit
vim.keymap.set("n", "<C-p>", "<cmd>Telescope find_files hidden=True theme=dropdown<CR>")
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope file_browser hidden=True theme=dropdown<CR>")
-- vim.keymap.set("n", "<C-p>", "<cmd>Files<CR>")
vim.keymap.set("n", "<leader>cs", "<cmd>Telescope colorscheme<CR>")
vim.keymap.set("n", "<leader>ct", "<cmd>! ctags -R<CR>")
vim.keymap.set("n", "<leader>fd", "<cmd>FileInDirectory<CR>")
vim.keymap.set("n", "<leader>pd", "<cmd>GrepInDirectory<CR>")
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope live_grep<CR>")
vim.keymap.set("n", "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find theme=ivy<CR>")
vim.keymap.set("n", "<leader>?", "<cmd>Telescope oldfiles theme=ivy<CR>")
vim.keymap.set("n", "<leader>b", "<cmd>Telescope buffers<CR>")
vim.keymap.set("n", "<leader>cd", "<cmd>Telescope zoxide list<CR>")

vim.keymap.set("n", "<Tab>", function()
    return vim.bo.filetype ~= "floaterm" and "<cmd>bn<CR>" or "<Tab>"
end, {expr = true})
vim.keymap.set("n", "<S-Tab>", function()
    return vim.bo.filetype ~= "floaterm" and "<cmd>bp<CR>" or "<Tab>"
end, {expr = true})

vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>")
vim.keymap.set("n", "<leader>tg", "<cmd>Telescope tags<CR>")
vim.keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches theme=ivy<CR>")
vim.keymap.set({"n", "v"}, "]g", "<cmd>Gitsigns next_hunk<CR>")
vim.keymap.set({"n", "v"}, "[g", "<cmd>Gitsigns prev_hunk<CR>")
vim.keymap.set("n", "<leader>P", "<cmd>Gitsigns preview_hunk_inline<CR>")
vim.keymap.set("n", "<leader>R", "<cmd>Gitsigns reset_hunk<CR>")
vim.keymap.set("n", "<leader>S", "<cmd>Gitsigns stage_hunk<CR>")
vim.keymap.set("v", "<leader>S", ":'<,'>Gitsigns stage_hunk<CR>")
vim.keymap.set("n", "<leader>U", "<cmd>Gitsigns undo_stage_hunk<CR>")
vim.keymap.set("v", "<leader>U", ":'<,'>Gitsigns undo_stage_hunk<CR>")
vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<CR>")
vim.keymap.set("n", "<leader>gO", "<cmd>LazyGitConfig<CR>")
vim.keymap.set("n", "<leader>gf", "<cmd>GitFiles<CR>")
vim.keymap.set("n", "<leader>gn", ":Git checkout -b ")
vim.keymap.set("n", "<leader>gr", "<cmd>Telescope grep_string<CR>")
vim.keymap.set("n", "<leader>gR", function()
    local search = vim.fn.input({prompt = "Search for: ", default = ""})
    if search == "" then return end
    vim.cmd("Telescope grep_string search=" .. search)
end)
vim.keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<CR>")
-- vim.keymap.set("n", "<leader>gl", "<cmd>Telescope git_bcommits<CR>")
vim.keymap.set("n", "<leader>gl", "<cmd>LazyGitFilterCurrentFile<CR>")
vim.keymap.set("n", "<leader>dvh", "<cmd>DiffviewOpen HEAD~1<CR>")
vim.keymap.set("n", "<leader>dvH", ":DiffviewOpen HEAD~")
vim.keymap.set("n", "<leader>dvl", "<cmd>DiffviewFileHistory<CR>")
vim.keymap.set("n", "<leader>dvo", "<cmd>DiffviewOpen<CR>")
vim.keymap.set("n", "<leader>ft", "<cmd>Telescope filetypes<CR>")

vim.keymap.set("n", "<leader>gwl", function()
    require("telescope").extensions.git_worktree.git_worktrees()
end, {silent = true})
vim.keymap.set("n", "<leader>gws", function()
    local is_bare_repo = vim.fn.system("git config --get core.bare")
    if is_bare_repo ~= "true\n" then
        print("use this remap only for bare repos!")
        return
    end
    require("telescope").extensions.git_worktree.create_git_worktree()
end)
-- TODO: add git worktree fetch remap?
vim.keymap.set("n", "<leader>gwc", function()
    local is_bare_repo = vim.fn.system("git config --get core.bare")
    if is_bare_repo ~= "true\n" then
        print("use this remap only for bare repos!")
        return
    end
    local path = vim.fn.input({prompt = "Enter path: ", default = ""})
    if path == "" then return end
    local branch = vim.fn.input({prompt = "Enter new branch name: ", default = ""})
    if branch == "" then return end
    local parent_branch = vim.fn.input({prompt = "Enter parent branch: ", default = ""})
    if parent_branch == "" or parent_branch == nil then
        parent_branch = vim.fn.system("! git rev-parse --abbrev-ref HEAD")
    end
    vim.cmd("!git branch " .. branch .. " " .. parent_branch)
    vim.cmd("!git worktree add ../" .. path .. " " .. branch)
    require("git-worktree").switch_worktree(path)
end)
-- TODO: check how to add telescope mapping and get rid of this
vim.keymap.set("n", "<leader>gwu", function()
    local is_bare_repo = vim.fn.system("git config --get core.bare")
    if is_bare_repo ~= "true\n" then
        print("use this remap only for bare repos!")
        return
    end
    local is_git_dir = vim.fn.glob('.git')
    if is_git_dir == "" then
        print("use this remap only inside gitdirs!")
        return
    end
    local path = vim.fn.input({prompt = "Enter path: ", default = ""})
    if path == "" then return end
    local cmd = "AsyncRun -cwd=../" .. path .. " git pull --ff-only"
    vim.cmd(cmd)
    vim.cmd.copen()
end)
local function async_git_op(op)
    local fun = function()
        vim.cmd("AsyncRun -cwd=./ git " .. op)
        vim.cmd.copen()
    end
    return fun
end
vim.keymap.set("n", "<leader>G", "<cmd>Git<CR>")
vim.keymap.set("n", "<leader>gc", "<cmd>Git commit<CR>")
vim.keymap.set("n", "<leader>gf", async_git_op("fetch"))
vim.keymap.set("n", "<leader>gp", async_git_op("pull --ff-only"))
vim.keymap.set("n", "<leader>gP", async_git_op("push"))

-- undotree
vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<CR>")

-- search & replace current word
vim.keymap.set("n", "<leader>sr", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

-- dap
vim.keymap.set("n", "<leader>du", function()
    require('dapui').toggle()
end)
vim.keymap.set("n", "<leader>db", "<cmd>DapToggleBreakpoint<CR>")
vim.keymap.set("n", "<leader>dB", function()
    require('dap').set_breakpoint(vim.fn.input('breakpoint condition:'))
end)
vim.keymap.set("n", "<leader>dc", "<cmd>DapContinue<CR>")
vim.keymap.set("n", "<leader>di", "<cmd>DapStepInto<CR>")
vim.keymap.set("n", "<leader>do", "<cmd>DapStepOut<CR>")
vim.keymap.set("n", "<leader>dO", "<cmd>DapStepOver<CR>")
vim.keymap.set("n", "<leader>dt", "<cmd>DapTerminate<CR>")
vim.keymap.set("n", "<leader>tr", "<cmd>TroubleToggle document_diagnostics<CR>")

-- select all with ctrl-a
-- vim.keymap.set("n", "<C-a>", "ggVG")
-- save file with ctrl-s
vim.keymap.set("n", "<C-s>", "<cmd>w<CR>")
vim.keymap.set("n", "<leader>op", "<cmd>! open .<CR><CR>")

-- harpoon
vim.keymap.set("n", "<leader>H", function()
    require('harpoon.ui').toggle_quick_menu()
end)
vim.keymap.set("n", "<leader>;", function()
    require('harpoon.mark').add_file()
end)
for i = 1, 9 do
    vim.keymap.set("n", "<leader>" .. i, function()
        require('harpoon.ui').nav_file(i)
        vim.cmd [[ normal zz ]]
    end)
end

-- nvim-tree
-- vim.keymap.set("n", "<leader>,", "<cmd>NvimTreeToggle<CR>")

-- rest-nvim
vim.keymap.set("n", "<localleader>rn", "<Plug>RestNvim<CR>")
vim.keymap.set("n", "<localleader>rp", "<Plug>RestNvimPreview<CR>")
vim.keymap.set("n", "<localleader>rl", "<Plug>RestNvimLast<CR>")

-- delete all buffers except current
vim.keymap.set("n", "<leader>ca", ":wa <bar> %bd <bar> e# <bar> bd# <CR><CR>")

-- add zz to nav remaps
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "G", "Gzz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<C-o>", "<C-o>zz")
vim.keymap.set("n", "<C-i>", "<C-i>zz")
vim.keymap.set("c", "<CR>", function()
    return vim.fn.getcmdtype() == '/' and '<CR>zzzv' or '<CR>'
end, {expr = true})

-- move lines around in visual mode
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- resize splits
-- TODO: fix this for all splits
vim.keymap.set("n", "<A-h>", "<cmd>vertical resize -2<CR>")
vim.keymap.set("n", "<A-l>", "<cmd>vertical resize +2<CR>")
vim.keymap.set("n", "<A-k>", "<cmd>resize -2<CR>")
vim.keymap.set("n", "<A-j>", "<cmd>resize +2<CR>")

-- delete without affecting registers
vim.keymap.set("n", "<leader>D", "\"_d")

-- paste without affecting registers
vim.keymap.set("v", "p", "\"_dP")

-- tagbar
vim.keymap.set("n", "<leader>tb", "<cmd>TagbarToggle<CR>")

-- select all
vim.keymap.set("n", "<leader>va", "ggVG")

-- yank all
vim.keymap.set("n", "<leader>ya", "<cmd>%y+<CR>")

-- navigate quickfix
vim.keymap.set("n", "<localleader>q", "<cmd>copen<CR>")
vim.keymap.set("n", "<localleader>.", "<cmd>cnext<CR>")
vim.keymap.set("n", "<localleader>,", "<cmd>cprev<CR>")

-- coderunner
vim.keymap.set("n", "<leader>x", "<cmd>RunFile<CR>")

-- clearjumps
vim.keymap.set("n", "<leader>cj", "<cmd>clearjumps<CR>")
vim.keymap.set("n", "<leader>jj", "<cmd>Telescope jumplist<CR>")

-- open zshrc and zshenv
vim.keymap.set("n", "<leader>nz", "<cmd>e ~/.zshrc<CR>")
vim.keymap.set("n", "<leader>ne", "<cmd>e ~/.zshenv<CR>")

-- universal diagnostic / lsp remaps
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
if vim.bo.filetype ~= "lua" then vim.keymap.set('n', '<leader>=', vim.lsp.buf.format) end

-- more textobjs
vim.keymap.set({"o", "x"}, "iS", function()
    require("various-textobjs").subword(true)
end)
vim.keymap.set({"o", "x"}, "aS", function()
    require("various-textobjs").subword(false)
end)
vim.keymap.set({"o", "x"}, "iv", function()
    require("various-textobjs").value(true)
end)
vim.keymap.set({"o", "x"}, "av", function()
    require("various-textobjs").value(false)
end)
vim.keymap.set({"o", "x"}, "in", function()
    require("various-textobjs").number(true)
end)
vim.keymap.set({"o", "x"}, "an", function()
    require("various-textobjs").number(false)
end)
vim.keymap.set({"o", "x"}, "ii", function()
    require("various-textobjs").indentation(true, true)
end)
vim.keymap.set({"o", "x"}, "ai", function()
    require("various-textobjs").indentation(false, false)
end)

-- todo-comments
vim.keymap.set("n", "]t", function()
    require("todo-comments").jump_next()
end, {desc = "Next todo comment"})
vim.keymap.set("n", "[t", function()
    require("todo-comments").jump_prev()
end, {desc = "Previous todo comment"})
vim.keymap.set("n", "<leader>td", "<cmd>TodoTelescope<CR>", {desc = "Open TODOs in telescope"})

-- symbols outline
vim.keymap.set("n", "<leader>so", "<cmd>SymbolsOutline<CR>", {desc = "Symbols Outline"})
