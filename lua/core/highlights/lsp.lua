local theme = require("themes." .. vim.g.nv_theme).base_16
local colors = require("themes." .. vim.g.nv_theme).base_30

return {
    DiagnosticError = { fg = colors.red },
    DiagnosticWarn = { fg = colors.yellow },
    DiagnosticInfo = { fg = colors.blue },
    DiagnosticHint = { fg = colors.purple },
    DiagnosticUnderlineError = { undercurl = true, sp = colors.red },
    DiagnosticUnderlineWarn = { undercurl = true, sp = colors.yellow },
    DiagnosticUnderlineInfo = { undercurl = true, sp = colors.blue },
    DiagnosticUnderlineHint = { undercurl = true, sp = colors.purple },
    LspCodeLens = { fg = colors.grey_fg },
    LspCodeLensSeparator = { fg = colors.grey_fg },
    LspReferenceText = { fg = colors.darker_black, bg = colors.white },
    LspReferenceRead = { fg = colors.darker_black, bg = colors.white },
    LspReferenceWrite = { fg = colors.darker_black, bg = colors.white },
    PreviewBorder = { fg = colors.statusline_bg, bg = colors.statusline_bg },
    PreviewFloat = { bg = colors.statusline_bg },
}
