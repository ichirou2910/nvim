local theme = require("themes." .. vim.g.nv_theme).base_16
local colors = require("themes." .. vim.g.nv_theme).base_30

return {
    ["@annotation"] = { fg = theme.base0F },
    ["@attribute"] = { fg = theme.base0A },
    ["@character"] = { fg = theme.base08 },
    ["@constructor"] = { fg = theme.base0C },

    ["@constant.builtin"] = { fg = theme.base09 },
    ["@constant.macro"] = { fg = theme.base08 },

    ["@error"] = { fg = theme.base08 },
    ["@exception"] = { fg = theme.base08 },
    ["@float"] = { fg = theme.base09 },

    ["@keyword"] = { fg = theme.base0E },
    ["@keyword.function"] = { fg = theme.base0E },
    ["@keyword.return"] = { fg = theme.base0E },

    ["@function"] = { fg = theme.base0D },
    ["@function.builtin"] = { fg = theme.base0D },
    ["@function.macro"] = { fg = theme.base08 },

    ["@keyword.operator"] = { fg = theme.base0E },
    ["@method"] = { fg = theme.base0D },
    ["@namespace"] = { fg = theme.base08 },
    ["@none"] = { fg = theme.base05 },
    ["@parameter"] = { fg = theme.base08 },
    ["@reference"] = { fg = theme.base05 },

    ["@punctuation.bracket"] = { fg = theme.base0F },
    ["@punctuation.delimiter"] = { fg = theme.base0F },
    ["@punctuation.special"] = { fg = theme.base08 },
    ["@punctuation.special.markdown"] = { fg = colors.orange, bold = true },

    ["@string.regex"] = { fg = theme.base0C },
    ["@string.escape"] = { fg = theme.base0C },

    ["@symbol"] = { fg = theme.base0B },

    ["@tag"] = { link = "Tag" },
    ["@tag.attribute"] = { link = "@property" },
    ["@tag.delimiter"] = { fg = theme.base0F },

    ["@text"] = { fg = theme.base05 },
    ["@text.strong"] = { bold = true },
    ["@text.emphasis"] = { fg = theme.base09 },
    ["@text.strike"] = { fg = theme.base00, strikethrough = true },
    ["@text.literal"] = { fg = theme.base09 },
    ["@text.uri"] = { fg = theme.base09 },
    ["@text.todo.unchecked"] = { fg = colors.blue }, -- For brackets and parens.
    ["@text.todo.checked"] = { fg = colors.green }, -- For brackets and parens.
    ["@text.literal.markdown_inline"] = { bg = "#333942", fg = colors.blue },
    ["@text.literal.markdown"] = { link = "Normal" },
    ["@text.diff.add"] = { link = "DiffAdd" },
    ["@text.diff.delete"] = { link = "DiffDelete" },

    ["@type.builtin"] = { fg = theme.base0A },

    ["@variable"] = { fg = theme.base05 },
    ["@variable.builtin"] = { fg = theme.base09 },

    ["@definition"] = { sp = theme.base04, underline = true },
    TSDefinitionUsage = { sp = theme.base04, underline = true },

    ["@scope"] = { bold = true },
    ["@field"] = { fg = theme.base08 },
    ["@property"] = { fg = theme.base08 },
    ["@include"] = { link = "Include" },
    ["@conditional"] = { link = "Conditional" },

    ["@class"] = { fg = theme.base0A },
    ["@struct"] = { fg = theme.base09 },
    ["@enum"] = { fg = theme.base0A },
    ["@enumMember"] = { fg = theme.base08 },
    ["@event"] = { fg = theme.base0A },
    ["@interface"] = { fg = theme.base09 },
    ["@modifier"] = { fg = theme.base0C },
    ["@regexp"] = { fg = theme.base0F },
    ["@typeParameter"] = { fg = theme.base0A },
    ["@decorator"] = { fg = theme.base0C },
}
