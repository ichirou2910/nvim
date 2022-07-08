local theme = require("themes." .. vim.g.nv_theme).base_16
local colors = require("themes." .. vim.g.nv_theme).base_30

return {
    NavicIconsFile = { fg = theme.base07 },
    NavicIconsModule = { fg = theme.base0A },
    NavicIconsNamespace = { fg = theme.base08 },
    NavicIconsPackage = { fg = theme.base08 },
    NavicIconsClass = { fg = theme.base0E },
    NavicIconsMethod = { fg = theme.base0D },
    NavicIconsProperty = { fg = theme.base08 },
    NavicIconsField = { fg = theme.base08 },
    NavicIconsConstructor = { fg = colors.blue },
    NavicIconsEnum = { fg = theme.base0E },
    NavicIconsInterface = { fg = theme.base08 },
    NavicIconsFunction = { fg = theme.base0D },
    NavicIconsVariable = { fg = theme.base0E },
    NavicIconsConstant = { fg = theme.base09 },
    NavicIconsString = { fg = colors.red },
    NavicIconsNumber = { fg = theme.base0E },
    NavicIconsBoolean = { fg = theme.base0E },
    NavicIconsArray = { fg = theme.base08 },
    NavicIconsObject = { fg = theme.base08 },
    NavicIconsKey = { fg = theme.base07 },
    NavicIconsNull = { fg = theme.base08 },
    NavicIconsEnumMember = { fg = theme.base0E },
    NavicIconsStruct = { fg = theme.base0E },
    NavicIconsEvent = { fg = theme.base0D },
    NavicIconsOperator = { fg = theme.base05 },
    NavicIconsTypeParameter = { fg = theme.base08 },
    NavicText = { fg = colors.white },
    NavicSeparator = { fg = colors.white },
}
