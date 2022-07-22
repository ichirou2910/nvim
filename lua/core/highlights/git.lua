local colors = require("themes." .. vim.g.nv_theme).base_30

return {
    GitSignsAdd = { fg = colors.green },
    GitSignsChange = { fg = colors.blue },
    GitSignsDelete = { fg = colors.red },
    GitSignsChangeDelete = { fg = colors.purple },
    DiffAdd = { bg = "#11291d" },
    DiffChange = { bg = "#0a3d62" },
    DiffDelete = { bg = "#36191c" },
    DiffText = { bg = "#833471" },
}
