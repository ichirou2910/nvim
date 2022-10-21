local theme = require("themes." .. vim.g.nv_theme).base_16
local colors = require("themes." .. vim.g.nv_theme).base_30

return {
    CmpItemAbbr = { fg = colors.white },
    CmpItemAbbrMatch = { fg = colors.blue, bold = true },
    CmpBorder = { fg = colors.float_bg, bg = theme.base00 },
    CmpDocBorder = { fg = colors.float_bg, bg = theme.base00 },
    CmpPmenu = { fg = nil, bg = colors.float_bg },
    CmpItemAbbrMatchFuzzy = { fg = theme.base0C },
    CmpItemKindClass = { fg = theme.base0E },
    CmpItemKindConstant = { fg = theme.base09 },
    CmpItemKindEnum = { fg = theme.base0E },
    CmpItemKindFunction = { fg = theme.base0D },
    CmpItemKindField = { fg = theme.base08 },
    CmpItemKindIdentifier = { fg = theme.base08 },
    CmpItemKindInterface = { fg = theme.base08 },
    CmpItemKindVariable = { fg = theme.base0E },
    CmpItemKindSnippet = { fg = colors.red },
    CmpItemKindText = { fg = theme.base0B },
    CmpItemKindStructure = { fg = theme.base0E },
    CmpItemKindType = { fg = theme.base0A },
    CmpItemKindKeyword = { fg = theme.base07 },
    CmpItemKindMethod = { fg = theme.base0D },
    CmpItemKindConstructor = { fg = colors.blue },
    CmpItemKindFolder = { fg = theme.base07 },
    CmpItemKindModule = { fg = theme.base0A },
    CmpItemKindProperty = { fg = theme.base08 },
    CmpItemKindUnit = { fg = theme.base0E },
    CmpItemKindFile = { fg = theme.base07 },
    CmpItemKindColor = { fg = colors.red },
    CmpItemKindString = { fg = colors.red },
    CmpItemKindReference = { fg = theme.base05 },
    CmpItemKindStruct = { fg = theme.base0E },
    CmpItemKindOperator = { fg = theme.base05 },
    CmpItemKindTypeParameter = { fg = theme.base08 },
}
