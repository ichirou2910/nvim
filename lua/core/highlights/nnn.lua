local theme = require("themes." .. vim.g.nv_theme).base_16
local colors = require("themes." .. vim.g.nv_theme).base_30

return {
    NnnNormal = { bg = colors.float_bg },
    NnnBorder = { fg = colors.float_bg, bg = theme.base00 },
}
