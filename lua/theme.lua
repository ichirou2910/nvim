local g = vim.g

g.nvchad_theme = "onedark"
local base16 = require "base16"
base16(base16.themes["onedark"], true)

require('highlights')

