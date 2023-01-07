local tna_ok, ts_node_action = pcall(require, "ts-node-action")
if not tna_ok then return end

local helpers = require("ts-node-action.helpers")

ts_node_action.setup({
    lua = {
        ["false"] = ts_node_action.toggle_boolean,
        ["true"] = ts_node_action.toggle_boolean,
        ["table_constructor"] = ts_node_action.toggle_multiline,
        ["arguments"] = ts_node_action.toggle_multiline,
    },
})
