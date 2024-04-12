local cmd_to_table = require("utils").cmd_to_table

local config_path = vim.fn.stdpath("config")
vim.keymap.set(
    "n",
    "<leader><leader>r",
    "<cmd> so " .. config_path .. "/lua/setup/remap.lua<CR>",
    { desc = "source remap.lua" }
)
vim.keymap.set(
    "n",
    "<leader><leader>s",
   "<cmd> so " .. config_path .. "/lua/setup/set.lua<CR>",
    { desc = "source set.lua" }
)

-- window switching
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "window left" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "window down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "window up" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "window right" })

-- terminals

vim.keymap.set("n", "<C-\\>", "<cmd>tabnew term://zsh<CR>i", { desc = "open terminal in vertical split" })

-- escape terminal mode
vim.keymap.set("t", "<localleader><Esc>", "<C-\\><C-n>", { desc = "escape terminal mode" })

-- netrw
vim.keymap.set("n", "<leader>,", "<cmd>Explore<CR>", { desc = "open netrw" })

vim.keymap.set("n", "<leader>gwc", function()
    local root = string.gsub(
        vim.fn.system('git worktree list --porcelain | head -1 | cut -d" " -f2'),
        "[\n\r]",
        ""
    )
    if root == nil then
        print("error getting bare repo root!")
        return
    end
    local branches = cmd_to_table("git branch -a")
    if rawequal(next(branches), nil) then
        print("no branches!")
        return
    end
    vim.ui.select(branches, { prompt = "select parent branch" }, function(pb)
        if pb == nil then
            return
        end
        local parent_branch = string.gsub(pb, "[*+]", "")
        local path = vim.fn.input({ prompt = "Enter worktree path from bare root: ", default = "" })
        if path == "" then
            return
        end
        local full_path = root .. "/" .. path
        local branch = vim.fn.input({ prompt = "Enter new branch name: ", default = "" })
        if branch == "" then
            return
        end
        print("running git cmds")
        vim.fn.system("git branch " .. branch .. " " .. parent_branch)
        vim.fn.system("git worktree add " .. full_path .. " " .. branch)
        require("git-worktree").switch_worktree(full_path)
    end)
end, { desc = "create new branch and checkout as a git worktree" })
vim.keymap.set("n", "<leader>gwu", function()
    local is_bare_repo = vim.fn.system("git config --get core.bare")
    if is_bare_repo ~= "true\n" then
        print("use this remap only for bare repos!")
        return
    end
    local root = string.gsub(
        vim.fn.system('git worktree list --porcelain | head -1 | cut -d" " -f2'),
        "[\n\r]",
        ""
    )
    if root == nil then
        print("not a bare repo!")
        return
    end
    local path = vim.fn.input({ prompt = "Enter worktree path from bare root: ", default = "" })
    if path == "" then
        return
    end
    local full_path = root .. "/" .. path
    print("full path" .. full_path)
    -- TODO: list only dirs here
    local paths = cmd_to_table("ls " .. full_path)
    if rawequal(next(paths), nil) then
        print("no worktrees found in path")
        return
    end
    vim.ui.select(paths, { prompt = "select path to update", default = "" }, function(p)
        if p == "" or p == nil then
            return
        end
        local cmd = "AsyncRun -cwd=" .. root .. "/" .. path .. "/" .. p .. " git pull --ff-only"
        vim.cmd(cmd)
        vim.cmd.copen()
    end)
end, { desc = "update git worktree" })
vim.keymap.set("n", "<leader>gwf", function()
    vim.cmd("AsyncRun git fetch --all")
    vim.cmd.copen()
end, { desc = "git fetch --all" })

---@param op string
---@return function
local function async_git_op(op)
    local fun = function()
        vim.cmd("AsyncRun -cwd=./ git " .. op)
        vim.cmd.copen()
    end
    return fun
end
vim.keymap.set("n", "<leader>gf", async_git_op("fetch"), { desc = "async git fetch" })
vim.keymap.set("n", "<leader>gp", async_git_op("pull --ff-only"), { desc = "async git pull" })
vim.keymap.set("n", "<leader>gP", async_git_op("push"), { desc = "async git push" })

-- save file with ctrl-s
vim.keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "save current file" })
vim.keymap.set("n", "<leader>op", "<cmd>! open .<CR><CR>", { desc = "open cwd in Finder" })

-- delete all buffers except current
vim.keymap.set(
    "n",
    "<leader>cab",
    ":wa <bar> %bd <bar> e# <bar> bd# <CR><CR>",
    { desc = "delete all buffers except current" }
)

-- add zz to nav remaps
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "ctrl-d and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "ctrl-u and center" })
vim.keymap.set("n", "G", "Gzz", { desc = "G and center" })
vim.keymap.set(
    "n",
    "n",
    "nzzzv",
    { desc = "next search result and center while not opening all the folds" }
)
vim.keymap.set(
    "n",
    "N",
    "Nzzzv",
    { desc = "previous search result and center while not opening all the folds" }
)
vim.keymap.set("n", "<C-o>", "<C-o>zz", { desc = "older position in jumplist and center" })
vim.keymap.set("n", "<C-i>", "<C-i>zz", { desc = "newer position in jumplist and center" })
vim.keymap.set("c", "<CR>", function()
    return vim.fn.getcmdtype() == "/" and "<CR>zzzv" or "<CR>"
end, { expr = true, desc = "center after hitting first search result" })
vim.keymap.set({ "n", "x" }, "<C-e>", "<C-e><C-e><C-e>")
vim.keymap.set({ "n", "x" }, "<C-y>", "<C-y><C-y><C-y>")

-- move lines around in visual mode
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "move visual selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "move visual selection up" })
vim.keymap.set("v", "<", "<gv", { desc = "indent visual selection left and retain selection" })
vim.keymap.set("v", ">", ">gv", { desc = "indent visual selection right and retain selection" })


-- show line / word count of visual selection
vim.keymap.set({"n", "x"}, "<leader>l", "g<C-g>", { desc = "show line, word and byte count of visual selection" })

-- open splits
vim.keymap.set("n", "<leader>|", "<cmd>vsp<CR>", { desc = "open vertical split" })
vim.keymap.set("n", "<leader>-", "<cmd>sp<CR>", { desc = "open horizontal split" })

-- resize splits
vim.keymap.set("n", "<A-h>", "<cmd>vertical resize -2<CR>", { desc = "reduce vertical split size" })
vim.keymap.set(
    "n",
    "<A-l>",
    "<cmd>vertical resize +2<CR>",
    { desc = "increase vertical split size" }
)
vim.keymap.set("n", "<A-k>", "<cmd>resize -2<CR>", { desc = "decrease horizontal split size" })
vim.keymap.set("n", "<A-j>", "<cmd>resize +2<CR>", { desc = "increase horizontal split size" })

-- yank all
vim.keymap.set("n", "<leader>ya", '<cmd>%y"<CR>', { desc = "yank all" })

-- yank to system clipboard
vim.keymap.set("x", "<leader>y", '"+y', { desc = "yank to clipboard" })
vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "yank till end of line to clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "paste from system clipboard" })

-- delete without affecting registers
vim.keymap.set("x", "<leader>D", '"_d', { desc = "delete but using _ register" })

-- paste without affecting registers
vim.keymap.set("x", "<leader>P", '"_dP', { desc = "paste but using _ register" })

-- select all
vim.keymap.set("n", "<leader>va", "ggVG", { desc = "visual select all" })

-- navigate quickfix
vim.keymap.set("n", "<localleader>q", "<cmd>copen<CR>", { desc = "open quickfix list" })
vim.keymap.set("n", "<localleader>.", "<cmd>cnext<CR>", { desc = "next quickfix item" })
vim.keymap.set("n", "<localleader>,", "<cmd>cprev<CR>", { desc = "previous quickfix item" })

-- open zshrc and zshenv
vim.keymap.set("n", "<leader>nz", "<cmd>e ~/.zshrc<CR>", { desc = "open .zshrc" })
vim.keymap.set("n", "<leader>ne", "<cmd>e ~/.zshenv<CR>", { desc = "open .zshenv" })

-- universal diagnostic / lsp remaps
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, { desc = "open diagnostic float" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "goto previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "goto next diagnostic" })
vim.keymap.set(
    "n",
    "<space>q",
    vim.diagnostic.setloclist,
    { desc = "add buffer diagnostics to loclist" }
)
if vim.bo.filetype ~= "lua" then
    vim.keymap.set("n", "<leader>=", vim.lsp.buf.format, { desc = "lsp buf format" })
end

-- highlights under cursor
if vim.fn.has("nvim-0.9.0") == 1 then
    vim.keymap.set("n", "<leader>hh", vim.show_pos, { desc = "Inspect position under cursor" })
end

-- search & replace current word
vim.keymap.set(
    "n",
    "<leader>sw",
    ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
    { desc = "search and replace cword in buffer" }
)

-- ctags
vim.keymap.set(
    "n",
    "<leader>ct",
    "<cmd>AsyncRun /opt/homebrew/Cellar/ctags/5.8_2/bin/ctags -R<CR>",
    { desc = "generate ctags" }
)


-- nohlsearch on escape
vim.keymap.set("n", "<esc>", "<cmd>nohlsearch<CR>", { desc = "nohlsearch" })
