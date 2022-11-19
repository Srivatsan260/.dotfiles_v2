local nnoremap = require("plugins.keymap").nnoremap
local tnoremap = require("plugins.keymap").tnoremap
local inoremap = require("plugins.keymap").inoremap
local vnoremap = require("plugins.keymap").vnoremap

nnoremap("<leader><leader>i", "<cmd> so ~/.config/nvim/lua/plugins/init.lua<CR>")
nnoremap("<leader><leader>r", "<cmd> so ~/.config/nvim/lua/plugins/remap.lua<CR>")
nnoremap("<leader><leader>s", "<cmd> so ~/.config/nvim/lua/plugins/set.lua<CR>")
nnoremap("<leader><leader>c", "<cmd> so ~/.config/nvim/after/plugin/color.lua<CR>")
nnoremap("<leader><leader>t", "<cmd> so ~/.config/nvim/after/plugin/treesitter.lua<CR>")
nnoremap("<leader><leader>l", "<cmd> so ~/.config/nvim/lua/plugins/lsp.lua<CR>")

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
nnoremap("<leader>fr",
         "<cmd>FloatermNew --wintype=float --height=0.9 --width=0.9 ranger<CR>")
tnoremap("<localleader><Esc>", "<C-\\><C-n>")

-- treesitter highlighting
nnoremap("<leader>th", "<cmd>TSBufToggle highlight<CR>")
nnoremap("<leader>tp", "<cmd>TSPlaygroundToggle<CR>")

-- FZF / telescope / lazygit
nnoremap("<C-p>", "<cmd>Telescope find_files hidden=True theme=dropdown<CR>")
-- nnoremap("<C-p>", "<cmd>Files<CR>")
nnoremap("<leader>cs", "<cmd>Telescope colorscheme<CR>")
nnoremap("<leader>ct", "<cmd>! ctags -R<CR>")
nnoremap("<leader>fd", "<cmd>FileInDirectory<CR>")
nnoremap("<leader>pd", "<cmd>GrepInDirectory<CR>")
nnoremap("<leader>ff", "<cmd>Telescope live_grep<CR>")
nnoremap("<leader>b", "<cmd>Telescope buffers<CR>")
nnoremap("<leader>fh", "<cmd>Telescope help_tags<CR>")
nnoremap("<leader>tg", "<cmd>Telescope tags<CR>")
nnoremap("<leader>gb", "<cmd>Telescope git_branches theme=ivy<CR>")
nnoremap("<leader>gg", "<cmd>LazyGit<CR>")
nnoremap("<leader>gf", "<cmd>GitFiles<CR>")
nnoremap("<leader>gr", "<cmd>Telescope grep_string<CR>")
nnoremap("<leader>gs", "<cmd>Telescope git_status<CR>")
-- nnoremap("<leader>gl", "<cmd>Telescope git_bcommits<CR>")
nnoremap("<leader>gl", "<cmd>LazyGitFilterCurrentFile<CR>")
nnoremap("<leader>dvh", "<cmd>DiffviewOpen HEAD~1<CR>")
nnoremap("<leader>dvH", ":DiffviewOpen HEAD~")
nnoremap("<leader>dvl", "<cmd>DiffviewFileHistory<CR>")
nnoremap("<leader>dvo", "<cmd>DiffviewOpen<CR>")
nnoremap("<leader>ft", "<cmd>Telescope filetypes<CR>")

-- undotree
nnoremap("<leader>u", "<cmd>UndotreeToggle<CR>")

-- sessions
nnoremap("<leader>ss", string.format(":mks! %s/*.vim<C-D><BS><BS><BS><BS><BS>",
                                     vim.g['sessions_dir']))
nnoremap("<leader>st", string.format(":so %s/*.vim<C-D><BS><BS><BS><BS><BS>",
                                     vim.g['sessions_dir']))
nnoremap("<leader>sp", "<cmd>Telescope sessions_picker theme=dropdown<CR>")

-- dap
nnoremap("<leader>du", "<cmd>lua require('dapui').toggle()<CR>")
nnoremap("<leader>db", "<cmd>DapToggleBreakpoint<CR>")
nnoremap("<leader>dB",
         "<cmd>lua require('dap').set_breakpoint(vim.fn.input('breakpoint condition:'))<CR>")
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
nnoremap("<leader>H", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>")
nnoremap("<leader>;", "<cmd>lua require('harpoon.mark').add_file()<CR>")
nnoremap("<leader>1", "<cmd>lua require('harpoon.ui').nav_file(1)<CR>")
nnoremap("<leader>2", "<cmd>lua require('harpoon.ui').nav_file(2)<CR>")
nnoremap("<leader>3", "<cmd>lua require('harpoon.ui').nav_file(3)<CR>")
nnoremap("<leader>4", "<cmd>lua require('harpoon.ui').nav_file(4)<CR>")
nnoremap("<leader>5", "<cmd>lua require('harpoon.ui').nav_file(5)<CR>")

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

-- move lines around in visual mode
vnoremap("J", ":m '>+1<CR>gv=gv")
vnoremap("K", ":m '<-2<CR>gv=gv")

-- ssr
nnoremap("<leader>sr", "<cmd>lua require('ssr').open()<CR>")

-- delete without affecting registers
nnoremap("<leader>D", "\"_d")
