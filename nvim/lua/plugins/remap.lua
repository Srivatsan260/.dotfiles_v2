local nnoremap = require("plugins.keymap").nnoremap
local tnoremap = require("plugins.keymap").tnoremap
local inoremap = require("plugins.keymap").inoremap
local vnoremap = require("plugins.keymap").vnoremap

nnoremap("K", function()
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

nnoremap("<leader><leader>i", "<cmd> so ~/.config/nvim/lua/plugins/init.lua<CR>")
nnoremap("<leader><leader>r", "<cmd> so ~/.config/nvim/lua/plugins/remap.lua<CR>")
nnoremap("<leader><leader>s", "<cmd> so ~/.config/nvim/lua/plugins/set.lua<CR>")
nnoremap("<leader><leader>c", "<cmd> so ~/.config/nvim/after/plugin/color.lua<CR>")
nnoremap("<leader><leader>t", "<cmd> so ~/.config/nvim/after/plugin/treesitter.lua<CR>")
nnoremap("<leader><leader>l", "<cmd> so ~/.config/nvim/lua/plugins/lsp_zero.lua<CR>")

-- copy file name to + register
nnoremap("<leader>cf", "<cmd>let @+=@%<CR>") -- absolute filepath
nnoremap("<leader>cF", "<cmd>let @+=expand('%:t')<CR>") -- filename

-- window switching
-- nnoremap("<C-h>", "<C-w>h")
-- nnoremap("<C-j>", "<C-w>j")
-- nnoremap("<C-k>", "<C-w>k")
-- nnoremap("<C-l>", "<C-w>l")

-- tab switching
nnoremap("<leader>tn", "<cmd>tabnew<CR>")
nnoremap("<leader>t.", "<cmd>tabnext<CR>")
nnoremap("<leader>t,", "<cmd>tabprev<CR>")
nnoremap("<leader>tc", "<cmd>tabclose<CR>")

-- netrw
nnoremap("<leader>,", "<cmd>Explore<CR>")

-- Floaterm
nnoremap("<leader>tt", "<cmd>FloatermToggle<CR>")
nnoremap("<leader>fl", "<cmd>Floaterms<CR>")
nnoremap("<leader>fn", ":FloatermNew --wintype=float --height=0.9 --width=0.9 ")
nnoremap("<leader>fr", "<cmd>FloatermNew --wintype=float --height=0.9 --width=0.9 ranger<CR>")
tnoremap("<localleader><Esc>", "<C-\\><C-n>")
tnoremap("<localleader>tt", "<cmd>FloatermToggle<CR>")

-- treesitter highlighting
nnoremap("<leader>th", "<cmd>TSBufToggle highlight<CR>")
nnoremap("<leader>tp", "<cmd>TSPlaygroundToggle<CR>")

nnoremap("<leader>tj", "<cmd>TSJToggle<CR>")

-- FZF / telescope / lazygit
nnoremap("<C-p>", "<cmd>Telescope find_files hidden=True theme=dropdown<CR>")
nnoremap("<leader>fb", "<cmd>Telescope file_browser hidden=True theme=dropdown<CR>")
-- nnoremap("<C-p>", "<cmd>Files<CR>")
nnoremap("<leader>cs", "<cmd>Telescope colorscheme<CR>")
nnoremap("<leader>ct", "<cmd>! ctags -R<CR>")
nnoremap("<leader>fd", "<cmd>FileInDirectory<CR>")
nnoremap("<leader>pd", "<cmd>GrepInDirectory<CR>")
nnoremap("<leader>ff", "<cmd>Telescope live_grep<CR>")
nnoremap("<leader>/", "<cmd>Telescope current_buffer_fuzzy_find theme=ivy<CR>")
nnoremap("<leader>b", "<cmd>Telescope buffers<CR>")
nnoremap("<leader>cd", "<cmd>Telescope zoxide list<CR>")

-- TODO: make these not work in terminal buffers
nnoremap("<Tab>", "<cmd>bn<CR>")
nnoremap("<S-Tab>", "<cmd>bp<CR>")

nnoremap("<leader>fh", "<cmd>Telescope help_tags<CR>")
nnoremap("<leader>tg", "<cmd>Telescope tags<CR>")
nnoremap("<leader>gb", "<cmd>Telescope git_branches theme=ivy<CR>")
nnoremap("<leader>gg", "<cmd>LazyGit<CR>")
nnoremap("<leader>gf", "<cmd>GitFiles<CR>")
nnoremap("<leader>gn", ":Git checkout -b ")
nnoremap("<leader>gr", "<cmd>Telescope grep_string<CR>")
nnoremap("<leader>gs", "<cmd>Telescope git_status<CR>")
-- nnoremap("<leader>gl", "<cmd>Telescope git_bcommits<CR>")
nnoremap("<leader>gl", "<cmd>LazyGitFilterCurrentFile<CR>")
nnoremap("<leader>dvh", "<cmd>DiffviewOpen HEAD~1<CR>")
nnoremap("<leader>dvH", ":DiffviewOpen HEAD~")
nnoremap("<leader>dvl", "<cmd>DiffviewFileHistory<CR>")
nnoremap("<leader>dvo", "<cmd>DiffviewOpen<CR>")
nnoremap("<leader>ft", "<cmd>Telescope filetypes<CR>")

nnoremap("<leader>gwl", function() require("telescope").extensions.git_worktree.git_worktrees() end,
         {silent = true})
nnoremap("<leader>gws", function()
    local is_bare_repo = vim.fn.system("git config --get core.bare")
    if is_bare_repo ~= "true\n" then
        print("use this remap only for bare repos!")
        return
    end
    require("telescope").extensions.git_worktree.create_git_worktree()
end)
nnoremap("<leader>gwc", function()
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
end)
-- TODO check how to add telescope mapping and get rid of this
nnoremap("<leader>gwu", function()
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

-- undotree
nnoremap("<leader>u", "<cmd>UndotreeToggle<CR>")

-- sessions
nnoremap("<leader>ss",
         string.format(":mks! %s/*.vim<C-D><BS><BS><BS><BS><BS>", vim.g['sessions_dir']))
nnoremap("<leader>st", string.format(":so %s/*.vim<C-D><BS><BS><BS><BS><BS>", vim.g['sessions_dir']))
nnoremap("<leader>sp", "<cmd>Telescope sessions_picker theme=dropdown<CR>")

-- dap
nnoremap("<leader>du", function() require('dapui').toggle() end)
nnoremap("<leader>db", "<cmd>DapToggleBreakpoint<CR>")
nnoremap("<leader>dB",
         function() require('dap').set_breakpoint(vim.fn.input('breakpoint condition:')) end)
nnoremap("<leader>dc", "<cmd>DapContinue<CR>")
nnoremap("<leader>di", "<cmd>DapStepInto<CR>")
nnoremap("<leader>do", "<cmd>DapStepOut<CR>")
nnoremap("<leader>dO", "<cmd>DapStepOver<CR>")
nnoremap("<leader>dt", "<cmd>DapTerminate<CR>")
nnoremap("<leader>tr", "<cmd>TroubleToggle document_diagnostics<CR>")

-- select all with ctrl-a
-- nnoremap("<C-a>", "ggVG")
-- save file with ctrl-s
nnoremap("<C-s>", "<cmd>w<CR>")
nnoremap("<leader>op", "<cmd>! open .<CR><CR>")

-- harpoon
nnoremap("<leader>H", function() require('harpoon.ui').toggle_quick_menu() end)
nnoremap("<leader>;", function() require('harpoon.mark').add_file() end)
nnoremap("<leader>1", function() require('harpoon.ui').nav_file(1) end)
nnoremap("<leader>2", function() require('harpoon.ui').nav_file(2) end)
nnoremap("<leader>3", function() require('harpoon.ui').nav_file(3) end)
nnoremap("<leader>4", function() require('harpoon.ui').nav_file(4) end)
nnoremap("<leader>5", function() require('harpoon.ui').nav_file(5) end)

-- nvim-tree
-- nnoremap("<leader>,", "<cmd>NvimTreeToggle<CR>")

-- rest-nvim
nnoremap("<localleader>rn", "<Plug>RestNvim<CR>")
nnoremap("<localleader>rp", "<Plug>RestNvimPreview<CR>")
nnoremap("<localleader>rl", "<Plug>RestNvimLast<CR>")

-- delete all buffers except current
nnoremap("<leader>ca", ":wa <bar> %bd <bar> e# <bar> bd# <CR><CR>")

-- fix C-d, C-u, G
nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")
nnoremap("G", "Gzz")
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")

-- move lines around in visual mode
vnoremap("J", ":m '>+1<CR>gv=gv")
vnoremap("K", ":m '<-2<CR>gv=gv")

-- ssr
nnoremap("<leader>sr", function() require('ssr').open() end)

-- delete without affecting registers
nnoremap("<leader>D", "\"_d")

-- tagbar
nnoremap("<leader>tb", "<cmd>TagbarToggle<CR>")

-- select all
nnoremap("<leader>va", "<cmd>normal ggVG<CR>")

-- yank all
nnoremap("<leader>ya", "<cmd>normal ggyG<C-o>zz<CR>")

-- navigate quickfix
nnoremap("<localleader>q", "<cmd>copen<CR>")
nnoremap("<localleader>.", "<cmd>cnext<CR>")
nnoremap("<localleader>,", "<cmd>cprev<CR>")
