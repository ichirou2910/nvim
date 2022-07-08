local theme = require("themes." .. vim.g.nv_theme).base_16
local colors = require("themes." .. vim.g.nv_theme).base_30

return {
    GitSignsAdd = { fg = colors.green },
    GitSignsChange = { fg = colors.blue },
    GitSignsDelete = { fg = colors.red },
    GitSignsChangeDelete = { fg = colors.purple },
    DiffAdd = { fg = colors.green },
    DiffChange = { fg = colors.blue },
    DiffDelete = { fg = colors.red },
    DiffText = { fg = colors.purple },
}
