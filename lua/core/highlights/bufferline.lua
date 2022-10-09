local theme = require("themes." .. vim.g.nv_theme).base_16
local colors = require("themes." .. vim.g.nv_theme).base_30

return {
    BufferCurrent = { bg = colors.black, fg = "#cdd6f4" },
    BufferCurrentIndex = { bg = colors.black, fg = colors.blue },
    BufferCurrentMod = { bg = colors.black, fg = colors.yellow },
    BufferCurrentSign = { bg = colors.black, fg = colors.blue },
    BufferCurrentTarget = { bg = colors.black, fg = colors.reed },
    BufferVisible = { bg = "#181825", fg = "#cdd6f4" },
    BufferVisibleIndex = { bg = "#181825", fg = colors.blue },
    BufferVisibleMod = { bg = "#181825", fg = colors.yellow },
    BufferVisibleSign = { bg = "#181825", fg = colors.grey },
    BufferVisibleTarget = { bg = "#181825", fg = colors.reed },
    BufferInactive = { bg = "#181825", fg = "#6c7086" },
    BufferInactiveIndex = { bg = "#181825", fg = "#6c7086" },
    BufferInactiveMod = { bg = "#181825", fg = colors.yellow },
    BufferInactiveSign = { bg = "#181825", fg = colors.grey },
    BufferInactiveTarget = { bg = "#181825", fg = colors.reed },
    BufferTabpages = { bg = "#181825", fg = nil },
    BufferTabpage = { bg = "#181825", fg = colors.blue },
}
