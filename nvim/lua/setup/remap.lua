local cmd_to_table = require("utils").cmd_to_table
local async_git_op = require("utils").async_git_op

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

vim.keymap.set(
    "n",
    "<C-\\>",
    "<cmd>tabnew term://zsh<CR>i",
    { desc = "open terminal in new tab" }
)

-- escape terminal mode
vim.keymap.set("t", "<localleader><Esc>", "<C-\\><C-n>", { desc = "escape terminal mode" })

-- netrw
vim.keymap.set("n", "<leader>,", "<cmd>Explore<CR>", { desc = "open netrw" })

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
        async_git_op({"pull", "--ff-only"}, root .. "/" .. p)
    end)
end, { desc = "update git worktree" })

vim.keymap.set("n", "<leader>gfa", function() async_git_op({"fetch", "--all"}) end, { desc = "git fetch --all" })
vim.keymap.set("n", "<leader>gft", function() async_git_op({"fetch", "--tags", "--force"}) end, { desc = "git fetch --tags --force" })
vim.keymap.set("n", "<leader>gsp", function() async_git_op({"stash", "pop"}) end, { desc = "git stash pop" })

vim.keymap.set("n", "<leader>gp", function() async_git_op({"pull", "--ff-only"}) end, { desc = "async git pull" })
vim.keymap.set("n", "<leader>gP", function() async_git_op("push") end, { desc = "async git push" })

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
vim.keymap.set(
    { "n", "x" },
    "<leader>l",
    "g<C-g>",
    { desc = "show line, word and byte count of visual selection" }
)

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
vim.keymap.set({"n", "x"}, "<leader>y", '"+y', { desc = "yank to clipboard" })
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
vim.keymap.set("n", "<leader>ct", function()
    if vim.fn.glob("dbt_project.yml") ~= "" then
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
                if ext == "sql" or ext == "py" then
                    io.write(basename .. "\t" .. file .. "\t" .. "1;\tv\n")
                end
            end
        end

        io.close(ctags)
    else
        vim.cmd([[ AsyncRun /opt/homebrew/Cellar/ctags/5.8_2/bin/ctags -R ]])
    end
end, { desc = "generate ctags" })

-- nohlsearch on escape
vim.keymap.set("n", "<esc>", "<cmd>nohlsearch<CR>", { desc = "nohlsearch" })
