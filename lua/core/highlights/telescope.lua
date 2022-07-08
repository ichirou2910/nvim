local theme = require("themes." .. vim.g.nv_theme).base_16
local colors = require("themes." .. vim.g.nv_theme).base_30

return {
    TelescopeBorder = { fg = colors.darker_black, bg = colors.darker_black },
    TelescopePromptBorder = { fg = colors.black2, bg = colors.black2 },
    TelescopePromptNormal = { fg = colors.white, bg = colors.black2 },
    TelescopePromptPrefix = { fg = colors.red, bg = colors.black2 },
    TelescopePreviewTitle = { fg = colors.black, bg = colors.green },
    TelescopePromptTitle = { fg = colors.black, bg = colors.red },
    TelescopeResultsTitle = { fg = colors.darker_black, bg = colors.darker_black },
    TelescopeSelection = { fg = colors.white, bg = colors.black2 },
    TelescopeNormal = { bg = colors.darker_black },
    TelescopeResultsDiffAdd = { fg = colors.green },
    TelescopeResultsDiffChange = { fg = colors.blue },
    TelescopeResultsDiffDelete = { fg = colors.red },
}
