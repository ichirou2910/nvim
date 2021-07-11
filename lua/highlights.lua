local base16 = require "base16"
local cmd = vim.cmd

local global_theme = "themes/onedark"
local colors = require(global_theme)

local white = colors.white
local black = colors.black
local one_bg = colors.one_bg
local one_bg2 = colors.one_bg2
local grey = colors.grey
local red = colors.red
local line = colors.line
local green = colors.green
local nord_blue = colors.nord_blue
local blue = colors.blue
local yellow = colors.yellow
local purple = colors.purple

-- for guifg , bg

local function fg(group, color)
    cmd("hi " .. group .. " guifg=" .. color)
end

local function bg(group, color)
    cmd("hi " .. group .. " guibg=" .. color)
end

local function fg_bg(group, fgcol, bgcol)
    cmd("hi " .. group .. " guifg=" .. fgcol .. " guibg=" .. bgcol)
end

-- blankline
fg("IndentBlanklineChar", line)

-- misc --
fg("LineNr", grey)
fg("Comment", grey)
fg("NvimInternalError", red)
fg("EndOfBuffer", black)

-- Pmenu
bg("Pmenu", one_bg)
bg("PmenuSbar", one_bg2)
bg("PmenuSel", green)
bg("PmenuThumb", nord_blue)

-- Gitgutter
fg_bg("GitGutterAdd", '#98c379', "NONE")
fg_bg("GitGutterChange", '#61afef', "NONE")
fg_bg("GitGutterDelete", '#e06c75', "NONE")
fg_bg("GitGutterChangeDelete", '#c678dd', "NONE")

-- line n.o
cmd "hi clear CursorLine"
fg("cursorlinenr", white)

-- NvimTree
fg("NvimTreeFolderIcon", blue)
fg("NvimTreeFolderName", blue)
fg("NvimTreeOpenedFolderName", blue)
fg("NvimTreeEmptyFolderName", blue)
fg("NvimTreeIndentMarker", one_bg2)
fg("NvimTreeVertSplit", "#3a404d")
bg("NvimTreeVertSplit", "NONE")

-- telescope
fg("TelescopeBorder", line)
fg("TelescopePromptBorder", line)
fg("TelescopeResultsBorder", line)
fg("TelescopePreviewBorder", grey)

-- === LspDiagnostics === ---
-- error / warnings
fg("LspDiagnosticsSignError", red)
fg("LspDiagnosticsVirtualTextError", red)
fg("LspDiagnosticsSignWarning", yellow)
fg("LspDiagnosticsVirtualTextWarning", yellow)

-- info
fg("LspDiagnosticsSignInformation", green)
fg("LspDiagnosticsVirtualTextInformation", green)

-- hint
fg("LspDiagnosticsSignHint", purple)
fg("LspDiagnosticsVirtualTextHint", purple)

-- === Treesitter stuff ===
local theme = base16.themes["onedark"]

fg("TSError", '#'..theme.base08)
fg("TSPunctDelimiter", '#'..theme.base0F)
fg("TSPunctBracket", "#2876b8")
fg("TSPunctSpecial", '#'..theme.base0F)
fg("TSConstant", '#'..theme.base09)
fg("TSConstBuiltin", '#'..theme.base0A)
fg("TSConstMacro", '#'..theme.base08)
fg("TSStringRegex", '#'..theme.base0C)
fg("TSString", '#'..theme.base0B)
fg("TSStringEscape", theme.base0C)
fg("TSCharacter", '#'..theme.base08)
fg("TSNumber", '#'..theme.base09)
fg("TSBoolean", '#'..theme.base09)
fg("TSFloat", '#'..theme.base09)
fg("TSAnnotation", "#e5c07b")
fg("TSAttribute", '#'..theme.base0A)
fg("TSNamespace", "#ff00ff")
fg("TSFuncBuiltin", '#'..theme.base0D)
fg("TSFunction", '#'..theme.base0D)
fg("TSFuncMacro", '#'..theme.base08)
fg("TSParameter", '#'..theme.base0C)
fg("TSParameterReference", '#'..theme.base0C)
fg("TSMethod", '#'..theme.base0E)
fg("TSField", '#'..theme.base08)
fg("TSProperty", '#'..theme.base0A)
fg("TSConstructor", '#'..theme.base0C)
fg("TSConditional", '#'..theme.base0E)
fg("TSRepeat", '#'..theme.base0A)
fg("TSLabel", '#'..theme.base0A)
fg("TSKeyword", '#'..theme.base0E)
fg("TSKeywordFunction", '#'..theme.base0E)
fg("TSKeywordOperator", '#'..theme.base0E)
fg("TSOperator", '#'..theme.base05)
fg("TSException", '#'..theme.base0A)
fg("TSType", '#'..theme.base0A)
fg("TSTypeBuiltin", '#'..theme.base0A)
fg("TSStructure", '#'..theme.base0E)
fg("TSInclude", '#'..theme.base0D)
fg("TSVariable", "#7eca9c")
fg("TSVariableBuiltin", '#'..theme.base0A)
fg("TSText", "#ffff00")
fg("TSStrong", "#ffff00")
fg("TSEmphasis", "#ffff00")
fg("TSUnderline", '#'..theme.base08)
fg("TSTitle", '#'..theme.base0D)
fg("TSLiteral", "#ffff00")
fg("TSURI", "#ffff00")
fg("TSTag", '#'..theme.base0A)
fg("TSTagDelimiter", '#'..theme.base0F)
-- Gitgutter
fg("GitGutterAdd", '#'..theme.base0B)
fg("GitGutterChange", '#'..theme.base0D)
fg("GitGutterDelete", '#'..theme.base08)
fg("GitGutterChangeDelete", '#'..theme.base0E)
