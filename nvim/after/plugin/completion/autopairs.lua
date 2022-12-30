local autopairs_ok, autopairs = pcall(require, "nvim-autopairs")
if not autopairs_ok then return end

autopairs.setup({enable_check_bracket_line = false, map_cr = true})
