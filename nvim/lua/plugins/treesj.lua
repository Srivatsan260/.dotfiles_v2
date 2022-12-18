local tsj = require('treesj')
local tsj_utils = require('treesj.langs.utils')

local langs = {
    python = {
        dict = tsj_utils.set_preset_for_dict(),
        list = tsj_utils.set_preset_for_list(),
        args = tsj_utils.set_preset_for_args(),
        argument_list = tsj_utils.set_preset_for_args(),
        parameters = tsj_utils.set_preset_for_args()
    }
}

tsj.setup({
    -- Use default keymaps
    -- (<space>m - toggle, <space>j - join, <space>s - split)
    use_default_keymaps = false,

    -- Node with syntax error will not be formatted
    check_syntax_error = true,

    -- If line after join will be longer than max value,
    -- node will not be formatted
    max_join_length = 120,

    -- hold|start|end:
    -- hold - cursor follows the node/place on which it was called
    -- start - cursor jumps to the first symbol of the node being formatted
    -- end - cursor jumps to the last symbol of the node being formatted
    cursor_behavior = 'hold',

    -- Notify about possible problems or not
    notify = true,
    langs = langs
})
