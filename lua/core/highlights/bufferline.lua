local theme = require("themes." .. vim.g.nv_theme).base_16
local colors = require("themes." .. vim.g.nv_theme).base_30

return {
    BufferCurrent = { link = "Normal", bold = true },
    -- BufferCurrentIndex = { fg = fg_special, bg = bg_current },
    -- BufferCurrentMod = { fg = fg_modified, bg = bg_current },
    -- BufferCurrentSign = { fg = fg_special, bg = bg_current },
    -- BufferCurrentTarget = { fg = fg_target, bg = bg_current, bold = true },
    --
    -- BufferVisible = { fg = fg_visible, bg = bg_visible },
    -- BufferVisibleIndex = { fg = fg_visible, bg = bg_visible },
    -- BufferVisibleMod = { fg = fg_modified, bg = bg_visible },
    -- BufferVisibleSign = { fg = fg_visible, bg = bg_visible },
    -- BufferVisibleTarget = { fg = fg_target, bg = bg_visible, bold = true },
    --
    -- BufferInactive = { fg = fg_inactive, bg = bg_inactive },
    -- BufferInactiveIndex = { fg = fg_subtle, bg = bg_inactive },
    -- BufferInactiveMod = { fg = fg_modified, bg = bg_inactive },
    -- BufferInactiveSign = { fg = fg_subtle, bg = bg_inactive },
    -- BufferInactiveTarget = { fg = fg_target, bg = bg_inactive, bold = true },
    --
    -- BufferTabpages = { fg = fg_special, bg = bg_inactive, bold = true },
    -- BufferTabpageFill = { fg = fg_inactive, bg = bg_inactive },
    BufferCurrentIcon = { link = "BufferCurrent" },
    BufferVisibleIcon = { link = "BufferVisible" },
    BufferInactiveIcon = { link = "BufferInactive" },
    BufferOffset = { link = "BufferTabpageFill" },

    -- BufferLineBackground = { fg = colors.light_grey, bg = colors.black2 },
    -- BufferLineBufferSelected = { fg = colors.white, bg = colors.black },
    -- BufferLineBufferVisible = { fg = colors.light_grey, bg = colors.black2 },
    -- BufferLineError = { fg = colors.light_grey, bg = colors.black2 },
    -- BufferLineErrorDiagnostic = { fg = colors.light_grey, bg = colors.black2 },
    -- BufferLineWarning = { fg = colors.light_grey, bg = colors.black2 },
    -- BufferLineWarningDiagnostic = { fg = colors.light_grey, bg = colors.black2 },
    -- BufferLineInfo = { fg = colors.light_grey, bg = colors.black2 },
    -- BufferLineInfoDiagnostic = { fg = colors.light_grey, bg = colors.black2 },
    -- BufferLineHint = { fg = colors.light_grey, bg = colors.black2 },
    -- BufferlineHintDiagnostic = { fg = colors.light_grey, bg = colors.black2 },
    -- BufferLineCloseButton = { fg = colors.light_grey, bg = colors.black2 },
    -- BufferLineCloseButtonVisible = { fg = colors.light_grey, bg = colors.black2 },
    BufferLineCloseButtonSelected = { fg = colors.red, bg = colors.black },
    -- BufferLineFill = { fg = colors.grey_fg, bg = colors.black2 },
    -- BufferLineIndicatorVisible = { fg = colors.white, bg = colors.black2 },
    BufferLineIndicatorSelected = { fg = colors.blue, bg = colors.black },
    -- BufferLineModified = { fg = colors.red, bg = colors.black2 },
    -- BufferLineModifiedVisible = { fg = colors.red, bg = colors.black2 },
    BufferLineModifiedSelected = { fg = colors.green, bg = colors.black },
    -- BufferLineSeparator = { fg = colors.black2, bg = colors.black2 },
    -- BufferLineSeparatorVisible = { fg = colors.black2, bg = colors.black2 },
    -- BufferLineSeparatorSelected = { fg = colors.black2, bg = colors.black2 },
    -- BufferLineTab = { fg = colors.light_grey, bg = colors.one_bg3 },
    -- BufferLineTabSelected = { fg = colors.black2, bg = colors.nord_blue },
    -- BufferLineTabClose = { fg = colors.red, bg = colors.black },
    -- BufferLineDuplicate = { fg = colors.fg, bg = colors.black2 },
    -- BufferLineDuplicateSelected = { fg = colors.red, bg = colors.black },
    -- BufferLineDuplicateVisible = { fg = colors.blue, bg = colors.black2 },
    -- BufferLineRightCustomAreaText1 = { fg = colors.white, bg = colors.bg },
    -- BufferLineRightCustomAreaText2 = { fg = colors.red, bg = colors.bg },
}
