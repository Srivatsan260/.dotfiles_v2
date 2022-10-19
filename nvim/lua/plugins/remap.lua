local nnoremap = require("plugins.keymap").nnoremap
local tnoremap = require("plugins.keymap").tnoremap
local inoremap = require("plugins.keymap").inoremap
local vnoremap = require("plugins.keymap").vnoremap

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
nnoremap("<leader>,", "<cmd>Ex<CR>")

-- Floaterm
nnoremap("<leader>tt", "<cmd>FloatermToggle<CR>")
nnoremap("<leader>fn", ":FloatermNew --wintype=float --height=0.9 --width=0.9 ")
tnoremap("<leader><Esc>", "<C-\\><C-n>")

-- treesitter highlighting
nnoremap("<leader>th", "<cmd>TSBufToggle highlight<CR>")
nnoremap("<leader>tp", "<cmd>TSPlaygroundToggle<CR>")

-- FZF / telescope / lazygit
nnoremap("<C-p>", "<cmd>Telescope find_files hidden=True theme=dropdown<CR>")
-- nnoremap("<C-p>", "<cmd>Files<CR>")
nnoremap("<leader>cs", "<cmd>Telescope colorscheme<CR>")
nnoremap("<leader>ff", "<cmd>Telescope live_grep<CR>")
nnoremap("<leader>b", "<cmd>Telescope buffers<CR>")
nnoremap("<leader>fh", "<cmd>Telescope help_tags<CR>")
nnoremap("<leader>tg", "<cmd>Telescope tags<CR>")
nnoremap("<leader>gb", "<cmd>Telescope git_branches theme=ivy<CR>")
nnoremap("<leader>gg", "<cmd>LazyGit<CR>")
nnoremap("<leader>gf", "<cmd>GitFiles<CR>")
nnoremap("<leader>gs", "<cmd>Telescope git_status<CR>")
-- nnoremap("<leader>gl", "<cmd>Telescope git_bcommits<CR>")
nnoremap("<leader>gl", "<cmd>LazyGitFilterCurrentFile<CR>")
nnoremap("<leader>ft", "<cmd>Telescope filetypes<CR>")

-- undotree
nnoremap("<leader>u", "<cmd>UndotreeToggle<CR>")

-- sessions
nnoremap("<leader>ss", string.format("<cmd>mks! %s/*.vim<C-D><BS><BS><BS><BS><BS>", vim.g['sessions_dir']))
nnoremap("<leader>sr", string.format("<cmd>so %s/*.vim<C-D><BS><BS><BS><BS><BS>", vim.g['sessions_dir']))
nnoremap("<leader>sp", "<cmd>Telescope sessions_picker<CR>")

-- dap
nnoremap("<leader>du", "<cmd>lua require('dapui').toggle()<CR>")
nnoremap("<leader>db", "<cmd>DapToggleBreakpoint<CR>")
nnoremap("<leader>dc", "<cmd>DapContinue<CR>")
nnoremap("<leader>di", "<cmd>DapStepInto<CR>")
nnoremap("<leader>do", "<cmd>DapStepOut<CR>")
nnoremap("<leader>dO", "<cmd>DapStepOver<CR>")
nnoremap("<leader>dt", "<cmd>DapTerminate<CR>")
nnoremap("<leader>tr", "<cmd>TroubleToggle<CR>")

-- clipboard
vnoremap("<C-c>", '"+y<CR>')

-- save file with ctrl-s
nnoremap("<C-s>", "<cmd>w<CR>")
