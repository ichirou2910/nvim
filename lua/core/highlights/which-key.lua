local theme = require("themes." .. vim.g.nv_theme).base_16
local colors = require("themes." .. vim.g.nv_theme).base_30

return {
    WhichKey = { fg = colors.blue, bg = colors.float_bg },
    WhichKeyBorder = { fg = colors.float_bg, bg = theme.base00 },
    WhichKeyFloat = { bg = colors.float_bg },
    WhichKeySeparator = { fg = colors.white },
    WhichKeyDesc = { fg = colors.red },
    WhichKeyGroup = { fg = colors.green },
    WhichKeyValue = { fg = colors.green },
}
