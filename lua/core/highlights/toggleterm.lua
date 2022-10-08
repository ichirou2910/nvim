local theme = require("themes." .. vim.g.nv_theme).base_16
local colors = require("themes." .. vim.g.nv_theme).base_30

return {
    ToggletermFloat = { bg = colors.float_bg },
    ToggletermBorder = { fg = colors.float_bg, bg = theme.base00 },
}
