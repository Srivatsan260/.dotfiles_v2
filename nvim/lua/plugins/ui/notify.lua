return {
    "rcarriga/nvim-notify",
    lazy = true,
    opts = {
        render = "compact",
        stages = "static",
    },
    init = function()
        vim.notify = require('notify')
    end
}
