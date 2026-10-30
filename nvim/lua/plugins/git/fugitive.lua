return {
    "tpope/vim-fugitive",
    dependencies = {
        "tommcdo/vim-fubitive",
        "tpope/vim-rhubarb",
    },
    keys = {
        { "<leader>G", "<cmd>Git<CR>", desc = "open fugitive" },
        { "<leader>gn", ":Git checkout -b ", desc = "checkout new branch" },
        {
            "<leader>gN",
            function ()
                local maybe_branch_name = string.gsub(
                    vim.fn.system("git branch --show-current"),
                    "\n",
                    ""
                )
                if vim.v.shell_error ~=0 then
                    vim.notify(
                        "Could not copy branch name: " .. maybe_branch_name,
                        vim.log.levels.ERROR
                    )
                    return
                end
                vim.fn.setreg("+", maybe_branch_name)
                vim.notify("copied branch name " .. maybe_branch_name .. " to clipboard")
            end,
            -- '<cmd>let @+ = system("git branch --show-current")<CR>',
            desc = "copy branch name"
        },
        { "<leader>gc", "<cmd>Git commit<CR>", desc = "commit using fugitive" },
        { "<leader>gb", "<cmd>Git blame<CR>", desc = "blame using fugitive" },
        { "<leader>gp", "<cmd>Git pull --ff-only<CR>", desc = "git pull" },
        { "<leader>gP", "<cmd>Git push<CR>", desc = "git push" },
        { "<leader>gfa", "<cmd>Git fetch --all<CR>", desc = "git fetch --all" },
        { "<leader>gft", "<cmd>Git fetch --tags<CR>", desc = "git fetch --tags --force" },
        { "<leader>gsp", "<cmd>Git stash pop<CR>", desc = "git stash pop" },
        {
            "<leader>gpr",
            function ()
                local utils = require("utils")
                local bases = utils.cmd_to_table([[ git for-each-ref --format='%(refname:short)' refs/heads ]])
                vim.ui.select(
                    bases,
                    { prompt = "select base branch for PR" },
                    function (branch)
                        print("selected " .. branch)
                        local title = vim.fn.input({ prompt = "Enter PR Title: " })
                        local body = vim.fn.input({ prompt = "Enter PR Body: " })
                        local out = vim.fn.system("gh pr create --base " .. branch .. ' --body "' .. body .. '" --title "' .. title .. '"')
                        if vim.v.shell_error then
                            vim.notify("error creating pr: " .. out, vim.log.levels.ERROR)
                        end
                    end
                )
            end
        },
    },
    cmd = { "Git", "GBrowse", "GRead", "GRemove", "GReset", "Gvdiffsplit" },
    lazy = true,
    config = function()
        vim.cmd("runtime! autoload/netrw/os.vim")
    end
}
