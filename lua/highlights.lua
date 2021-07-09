local base16 = require "base16"
local cmd = vim.cmd

local global_theme = "themes/onedark"
local colors = require(global_theme)

local white = colors.white
local darker_black = colors.darker_black
local black = colors.black
local black2 = colors.black2
local one_bg = colors.one_bg
local one_bg2 = colors.one_bg2
local one_bg3 = colors.one_bg3
local light_grey = colors.light_grey
local grey = colors.grey
local grey_fg = colors.grey_fg
local red = colors.red
local line = colors.line
local green = colors.green
local vibrant_green = colors.vibrant_green
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
fg_bg("GitGutterAdd", vibrant_green, "NONE")
fg_bg("GitGutterChange", blue, "NONE")
fg_bg("GitGutterDelete", red, "NONE")

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

-- fg("NvimTreeRootFolder", darker_black)
-- bg("NvimTreeNormal", darker_black)
-- fg_bg("NvimTreeStatuslineNc", darker_black, darker_black)

-- telescope
fg("TelescopeBorder", line)
fg("TelescopePromptBorder", line)
fg("TelescopeResultsBorder", line)
fg("TelescopePreviewBorder", grey)

-- LspDiagnostics ---

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

-- bufferline

fg_bg("BufferLineFill", grey_fg, black2)
fg_bg("BufferLineBackground", light_grey, black2)

fg_bg("BufferLineBufferVisible", light_grey, black2)
fg_bg("BufferLineBufferSelected", white, black)

cmd "hi BufferLineBufferSelected gui=bold"

-- tabs
fg_bg("BufferLineTab", light_grey, one_bg3)
fg_bg("BufferLineTabSelected", black2, nord_blue)
fg_bg("BufferLineTabClose", red, black)

fg_bg("BufferLineIndicator", black2, black2)
fg_bg("BufferLineIndicatorSelected", black, black)

-- separators
fg_bg("BufferLineSeparator", black2, black2)
fg_bg("BufferLineSeparatorVisible", black2, black2)
fg_bg("BufferLineSeparatorSelected", black, black2)

-- modified buffers
fg_bg("BufferLineModified", red, black2)
fg_bg("BufferLineModifiedVisible", red, black2)
fg_bg("BufferLineModifiedSelected", green, black)

-- close buttons
fg_bg("BufferLineCLoseButtonVisible", light_grey, black2)
fg_bg("BufferLineCLoseButton", light_grey, black2)
fg_bg("BufferLineCLoseButtonSelected", red, black)

-- dashboard

fg("DashboardHeader", grey_fg)
fg("DashboardCenter", grey_fg)
fg("DashboardShortcut", grey_fg)
fg("DashboardFooter", grey_fg)

-- Default nvim bg (based on terminal bg)
-- cmd "hi Normal guibg=#1e222a"

-- ========================
-- Treesitter stuff

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
fg("GitGutterAdd", '#'..theme.base0B, "NONE")
fg("GitGutterChange", '#'..theme.base0D, "NONE")
fg("GitGutterDelete", '#'..theme.base08, "NONE")
fg("GitGutterChangeDelete", '#'..theme.base0E, "NONE")
