if vim.fn.has("nvim-0.9.0") ~= 1 then return end

local s_ok, statuscol = pcall(require, "statuscol")
if not s_ok then return end

local builtin = require("statuscol.builtin")
local opts = {
    setopt = true, -- whether to set the 'statuscolumn', providing builtin click actions
    separator = " ", -- separator between line number and buffer text ("│" or extra " " padding)
    -- Builtin line number string options for ScLn() segment
    thousands = false, -- or line number thousands separator string ("." / ",")
    relculright = false, -- whether to right-align the cursor line number with 'relativenumber' set
    -- Custom line number string options for ScLn() segment
    lnumfunc = nil, -- custom function called by ScLn(), should return a string
    reeval = false, -- whether or not the string returned by lnumfunc should be reevaluated
    -- Builtin 'statuscolumn' options
    order = "FSNs", -- order of the fold, sign, line number and separator segments
    ft_ignore = nil, -- lua table with filetypes for which 'statuscolumn' will be unset
    -- Click actions
    Lnum = builtin.lnum_click,
    FoldPlus = builtin.foldplus_click,
    FoldMinus = builtin.foldminus_click,
    FoldEmpty = builtin.foldempty_click,
    DapBreakpointRejected = builtin.toggle_breakpoint,
    DapBreakpoint = builtin.toggle_breakpoint,
    DapBreakpointCondition = builtin.toggle_breakpoint,
    DiagnosticSignError = builtin.diagnostic_click,
    DiagnosticSignHint = builtin.diagnostic_click,
    DiagnosticSignInfo = builtin.diagnostic_click,
    DiagnosticSignWarn = builtin.diagnostic_click,
    GitSignsTopdelete = builtin.gitsigns_click,
    GitSignsUntracked = builtin.gitsigns_click,
    GitSignsAdd = builtin.gitsigns_click,
    GitSignsChangedelete = builtin.gitsigns_click,
    GitSignsDelete = builtin.gitsigns_click
}

statuscol.setup(opts)
