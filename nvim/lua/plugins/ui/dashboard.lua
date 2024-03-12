-- TODO: try dashboard.nvim instead of alpha-nvim
return {
    {
        "goolord/alpha-nvim",
        dependencies = { "kyazdani42/nvim-web-devicons" },
        config = function()
            local if_nil = vim.F.if_nil
            local default_terminal = {
                type = "terminal",
                command = nil,
                width = 69,
                height = 8,
                opts = { redraw = true, window_config = {} },
            }
            local default_header = {
                type = "text",
                val = {
                    [[                                     ╓φ╗╗▄▄╓,__ ]],
                    [[                                 _▄▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓╗▄_   ]],
                    [[                              _▄▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓æ▄_ ]],
                    [[                            ╓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓╗, ]],
                    [[                          ▄██████▄▄▄▄▄╙▀▀▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓╗_ ]],
                    [[                        ▄██████████████████▄▄╙▀▀▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▌_ ]],
                    [[                     ,╓▄▄╗╗φφ╗╗╗▄▄▄▄╠╠▀▀▀████████▄▄╙▀▓▓▓▓▓▓▓▓▓▓▓▓▓▓▌_ ]],
                    [[               ,╓▄φ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓╗▄╠▀▀██████▄╙▀▓▓▓▓▓▓▓▓▓▓▓▓▒ ]],
                    [[           ._^╙╙▀▀▀▀Γ└░T╙▀╣▓▓▓▓▓▀▀▀▀▀▀▀▓▓▓▓▓▓▓▓▓▌▄J▀██████▄╙▀▓▓▓▓▓▓▓▓▒╠╕ ]],
                    [[       «╗▒╠╠╠╠╠╠▒╠╙_░░░=░░=____=░░░░░░=_.╙╣▓▓▓▓▓▓▓▓▓▓▄╙▀█████▄▄╙▓▓▓▓▓▒╠╠▒ ]],
                    [[         `╙╠╠╠╠╝^_=░░=`_²`  ``|░░░░░░░░░░░__╙▓▓▓▓▓▓▓▓▓▓▓φ▄▀█████▄╙▀▓▓╠╠╠╠⌐ ]],
                    [[  ▄██_     ²╠╝^╓@▒▒▒' ░.______ |`'░░░░░░░░░'░_.└╙▀▓▓▓▓▓▓▓▓▓φ╙▀█████▄╙╠╠╠╠H ]],
                    [[ ▐████        [╬╬╬╬╩,▒░░░'░░░░`,▌ ░░░░░░░░= ░░░```-.__╙▓▓▓▓▓▓▓▄╙█████▄²╠╠H ]],
                    [[ █████▀__   _░²╝╣╝╩ ╚Ü░░`=░░= ▓▓▓ ░░░░░░░░` |░░____  `_ ╙▓▓▓▓▓▓▓▌╠▀████▄╙H ]],
                    [[ ████████   =``_░░ |░░' _░=`▄▓▓▓█ :░░░░░░░ ║ |░░░_|░_  ░__'╙▀▓▓▓▓▓▓▄▀████⌐ ]],
                    [[ ²██████M     =░░░ ░'╓▓ »'╓▓▓▓███ =░░|░░░░ ▓█ |░░: |░░░░░░░░_ ╙▓▓▓▓▓▓▄▀██▌ ]],
                    [[   ╙▓▓▓▌   _=░░░░░ `▄▓█_`▓▓▓█████▌'░░ |░░= ▓▓█╕!░: ▄!░░░░░=░░░_└▓▓▓▓▓▓▓▄▀▌ ]],
                    [[     ╙███_=:░`░░░░ ║█▌╙ ╙╙▀▀▀█████ ░`▐_|░ ║▓▓██▌`░ ▓▄`░░░'|░░░░_`▓▓▓▓▓▓▓▌_ ]],
                    [[       ███▄`_░░░'_▄██▄███████▄█████` ▓█▄`╓▓╙█████▄ ▓▓▌_|=_╓φ▒▒▒▒_ ╙╝▓▓▓▓▓▓▄ ]],
                    [[        ╙███▄`= ▓███████████████████▐██▓▄▄┐ ╙▀█████▓▓▓▓▌ ░╣╬╬╬╬╬▒░░___╙▓▓▓▓▓_ ]],
                    [[          ████M▐██████████████████████████████▄,╙██▓▓▓▓▌|░╚╣╬╬╬╬╬╬▒░░:_ ▓▓▓▓▓╕ ]],
                    [[          _╙███'█████████████████████████████████,²▓▓▓█ :`░»└└│╙╩╩Ü░░░░ _▀▓▓▓▓ ]],
                    [[         `   ▀██╙██████████████████████████████████▓▓▓▌|░ ░░░░░░░░░░░░░_j▒≥╓,╙▌ ]],
                    [[             _'▀█▄╙▀████████████╒▓▓Ö███████████████▓▓▓ = _░░░░░░░░░:░`░░ ╠╠╠╠H_ ]],
                    [[             := ^███▄╙▀████████▌╫▓▓▓H█████████████▓▓▓█'  ░░░░░░░░░░░░ `░=  `ⁿ╙ ]],
                    [[                  ╙██,__ "▀▀████▄▓▓▓▌███████████▓▓▓▓▓▌é ░░░░░░░░░░░░=   =_ ]],
                    [[                 __-_` `,╠╠▒K╔╓╓╙╙▀▀▀▀██████▀▀▀▀▀╙╙└   ░░░░░=░░░`=░░`    `. ]],
                    [[                   ``` ▄▒▒▒╠╠╠╠╠^_ ª▀▓█▓▓▓▓▓▓█` ,╠╠╠R ░░░=`_░░░  |░░ ]],
                    [[                   ╗φ▓▓▓▓▓▓▓▀▓▓H_ ▓▓▓▄╙[▄▄╙▀▀ `,╠▒▒▒ ░=`   ░░=    ░= ]],
                    [[                   ║▓▓▓▓▓▓▓▀Æ▓▌_ ▓▓▓▓║▓▓║▓▓▀_`╔▓▓▓▓▌_▄@▓▄ '░`     | ]],
                    [[                    ▀▓▓▓▓▓╓▓▓▓ `____,╙╙╙╙╙▀_ ¢▓▓▓▓▓▓▓▓▓▓▓▓▄ ]],
                    [[                       '╙╒▓▓▓▓▓▌╗▄▄▄╓,,,____Æ▓M▓▓▓▓▓▓▓▓╬╠╠Ü ]],
                    [[                         ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ ╫▓▓▓▓▓▒╠╠╠╩ ]],
                    [[                         ╚▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ ╠╠╠╠░╠╠╠R^___ ]],
                    [[                          ╙╠╠╠╠╝▓▓▓▓▓▓▓▓▓▓▓▓╣▒H,"╙╙^"___  ` ]],
                    [[                            ╙╚╙╙╠╠╠╠╠╠╠╠╠╠░╠╠╠╠╠╠R  ``-` ╓▓█_ ]],
                    [[                           `  ___`^^^`_`'^^^',____      '▓▓██▄ ]],
                    [[                          Æ╗   `_ -        ```__,╔j╗_     █▓██▌ ]],
                    [[                        ╔▓▓▓ ` φ▒╠╠▒,`` `,╠╠╠╠╠╠╙╓╠╠╠▒≥_   ║▓███_ ]],
                    [[                      ,▓▓▓▓▓▒▄▓▓▓▓▓▓▓▌ ` ▓▓▒▒╝Ü▄╠╠╠╠╠╠╠╠D╓  ╙▓███▌ ]],
                    [[                     +▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀ ª▀▀▀▀▀▀▀▀▀╜╙╙╙╙╙╙╙╙º  ▀▀▀▀▀─ ]],
                },
                opts = {
                    position = "center",
                    hl = "Type",
                    -- wrap = "overflow";
                },
            }
            local footer =
                { type = "text", val = "", opts = { position = "center", hl = "Number" } }
            local leader = "SPC"
            --- @param sc string
            --- @param txt string
            --- @param keybind string? optional
            --- @param keybind_opts table? optional
            local function button(sc, txt, keybind, keybind_opts)
                local sc_ = sc:gsub("%s", ""):gsub(leader, "<leader>")
                local opts = {
                    position = "center",
                    shortcut = sc,
                    cursor = 5,
                    width = 50,
                    align_shortcut = "right",
                    hl_shortcut = "Keyword",
                }
                if keybind then
                    keybind_opts =
                        if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
                    opts.keymap = { "n", sc_, keybind, keybind_opts }
                end
                local function on_press()
                    local key = vim.api.nvim_replace_termcodes(
                        keybind or sc_ .. "<Ignore>",
                        true,
                        false,
                        true
                    )
                    vim.api.nvim_feedkeys(key, "t", false)
                end
                return { type = "button", val = txt, on_press = on_press, opts = opts }
            end
            local buttons = {
                type = "group",
                val = {
                    button("SPC ,", "פּ  Open Netrw", "<cmd>Ex<CR>"),
                    button("e", "  New file", "<cmd>ene <CR>"),
                    button("<C-p>", "  Find file"),
                    button("SPC ?", "  Recently opened files"),
                },
                opts = { spacing = 1 },
            }
            local section = {
                terminal = default_terminal,
                header = default_header,
                buttons = buttons,
                footer = footer,
            }
            local config = {
                layout = {
                    { type = "padding", val = 2 },
                    section.header,
                    { type = "padding", val = 2 },
                    section.buttons,
                    section.footer,
                },
                opts = { margin = 5 },
            }
            local alpha_config = {
                button = button,
                section = section,
                config = config,
                -- theme config
                leader = leader,
                -- deprecated
                opts = config,
            }
            local alpha = require("alpha")
            alpha.setup(alpha_config.config)
        end,
    },
}
