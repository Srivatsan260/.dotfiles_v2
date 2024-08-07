return {
    {
        "rcarriga/nvim-dap-ui",
        name = "dapui",
        dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
        lazy = true,
        config = function()
            require('dapui').setup({
                icons = { expanded = "▾", collapsed = "▸" },
                mappings = {
                    -- Use a table to apply multiple mappings
                    expand = { "<CR>", "<2-LeftMouse>" },
                    open = "o",
                    remove = "d",
                    edit = "e",
                    repl = "r",
                    toggle = "t",
                },
                -- Expand lines larger than the window
                -- Requires >= 0.7
                expand_lines = true,
                -- Layouts define sections of the screen to place windows.
                -- The position can be "left", "right", "top" or "bottom".
                -- The size specifies the height/width depending on position. It can be an Int
                -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
                -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
                -- Elements are the elements shown in the layout (in order).
                -- Layouts are opened in order so that earlier layouts take priority in window sizing.
                layouts = {
                    {
                        elements = {
                            -- Elements can be strings or table with id and size keys.
                            { id = "scopes", size = 0.25 },
                            "breakpoints",
                            "stacks",
                            "watches",
                        },
                        size = 40, -- 40 columns
                        position = "left",
                    },
                    {
                        elements = { "repl", "console" },
                        size = 0.25, -- 25% of total lines
                        position = "bottom",
                    },
                },
                floating = {
                    max_height = 0.3, -- These can be integers or a float between 0 and 1.
                    max_width = 0.3, -- Floats will be treated as percentage of your screen.
                    border = "single", -- Border style. Can be "single", "double" or "rounded"
                    mappings = { close = { "q", "<Esc>" } },
                },
                windows = { indent = 1 },
                render = {
                    max_type_length = nil, -- Can be integer or nil.
                    max_value_lines = 100, -- Can be integer or nil.
                },
            })
        end,
        keys = {
            {
                "<leader>du",
                function()
                    require("dapui").toggle()
                end,
                desc = "toggle dap ui",
            }
        },
    },
    {
        "leoluz/nvim-dap-go",
        lazy = true,
        dependencies = {"mfussenegger/nvim-dap"},
    },
    {
        "mfussenegger/nvim-dap",
        lazy = true,
        config = function()
            local dap_ok, dap = pcall(require, "dap")
            if not dap_ok then
                return
            end

            local py_virtual_env = os.getenv("VIRTUAL_ENV")
            if py_virtual_env ~= nil then
                dap.adapters.python = {
                    type = "executable",
                    command = os.getenv("VIRTUAL_ENV") .. "/bin/python",
                    args = { "-m", "debugpy.adapter" },
                }
                dap.configurations.python = {
                    {
                        type = "python",
                        request = "launch",
                        name = "launch file",
                        program = "${file}",
                        pythonPath = os.getenv("VIRTUAL_ENV") .. "/bin/python",
                        justMyCode = false,
                    },
                }
            end

            dap.adapters.lldb = { type = "executable", command = "lldb-vscode", name = "lldb" }
            dap.configurations.rust = {
                {
                    name = "Launch",
                    type = "lldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input(
                            "Path to executable: ",
                            vim.fn.getcwd() .. "/target/debug",
                            "file"
                        )
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                    args = {},
                },
            }
            dap.adapters.go = function(callback, config)
                local stdout = vim.loop.new_pipe(false)
                local handle
                local pid_or_err
                local port = 38697
                local opts = {
                    stdio = { nil, stdout },
                    args = { "dap", "-l", "127.0.0.1:" .. port },
                    detached = true,
                }
                handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
                    stdout:close()
                    handle:close()
                    if code ~= 0 then
                        print("dlv exited with code", code)
                    end
                end)
                assert(handle, "Error running dlv: " .. tostring(pid_or_err))
                stdout:read_start(function(err, chunk)
                    assert(not err, err)
                    if chunk then
                        vim.schedule(function()
                            require("dap.repl").append(chunk)
                        end)
                    end
                end)
                -- Wait for delve to start
                vim.defer_fn(function()
                    callback({ type = "server", host = "127.0.0.1", port = port })
                end, 100)
            end
            dap.configurations.go = {
                { type = "go", name = "Debug", request = "launch", program = "${file}" },
                {
                    type = "go",
                    name = "Debug test", -- configuration for debugging test files
                    request = "launch",
                    mode = "test",
                    program = "${file}",
                }, -- works with go.mod packages and sub packages
                {
                    type = "go",
                    name = "Debug test (go.mod)",
                    request = "launch",
                    mode = "test",
                    program = "./${relativeFileDirname}",
                },
            }
        end,
        keys = {
            { "<leader>db", "<cmd>DapToggleBreakpoint<CR>", desc = "toggle debug breakpoint" },
            {
                "<leader>dB",
                function()
                    require("dap").set_breakpoint(vim.fn.input("breakpoint condition:"))
                end,
                desc = "toggle conditional breakpoint",
            },
            { "<F2>", "<cmd>DapContinue<CR>", desc = "debug continue" },
            { "<F3>", "<cmd>DapStepInto<CR>", desc = "debug step into" },
            { "<F4>", "<cmd>DapStepOut<CR>", desc = "debug step out" },
            { "<F5>", "<cmd>DapStepOver<CR>", desc = "debug step over" },
            { "<F6>", "<cmd>DapTerminate<CR>", desc = "terminate current debug session" },
        },
    },
}
