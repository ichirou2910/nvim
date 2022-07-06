local g = vim.g

local highlight = require("core.utils").highlight

-- Activate highlighting
vim.api.nvim_command("syntax on")
if vim.fn.has("termguicolors") == 1 then
    vim.o.termguicolors = true
end

-- Available themes
-- onedark, github, eighties, flat, oceanic, seti, night
g.nv_theme = "radium"

local theme = require("themes." .. g.nv_theme).base_16
local colors = require("themes." .. g.nv_theme).base_30

highlight("IndentBlankLineChar", colors.line, nil, nil, nil)
highlight("IndentBlankLineSpaceChar", colors.line, nil, nil, nil)
highlight("IndentBlankLineContextChar", colors.grey, nil, nil, nil)
highlight("IndentBlankLineContextStart", colors.one_bg2, nil, nil, nil)

highlight("BufferLineBackground", colors.light_grey, colors.black2, nil, nil)
highlight("BufferlineIndicatorVisible", colors.black2, colors.black2, nil, nil)
highlight("BufferlineBufferSelected", colors.white, colors.black, nil, nil)
highlight("BufferlineBufferVisible", colors.light_grey, colors.black2, nil, nil)
highlight("BufferlineError", colors.light_grey, colors.black2, nil, nil)
highlight("BufferlineErrorDiagnostic", colors.light_grey, colors.black2, nil, nil)
highlight("BufferlineWarning", colors.light_grey, colors.black2, nil, nil)
highlight("BufferlineWarningDiagnostic", colors.light_grey, colors.black2, nil, nil)
highlight("BufferlineWarningDiagnosticNC", colors.light_grey, colors.black2, nil, nil)
highlight("BufferlineInfo", colors.light_grey, colors.black2, nil, nil)
highlight("BufferlineInfoDiagnostic", colors.light_grey, colors.black2, nil, nil)
highlight("BufferlineHint", colors.light_grey, colors.black2, nil, nil)
highlight("BufferlineHintDiagnostic", colors.light_grey, colors.black2, nil, nil)
highlight("BufferLineCloseButton", colors.light_grey, colors.black2, nil, nil)
highlight("BufferLineCloseButtonVisible", colors.light_grey, colors.black2, nil, nil)
highlight("BufferLineCloseButtonSelected", colors.red, colors.black, nil, nil)
highlight("BufferLineFill", colors.grey_fg, colors.black2, nil, nil)
highlight("BufferlineIndicatorSelected", colors.black, colors.black, nil, nil)
highlight("BufferLineModified", colors.red, colors.black2, nil, nil)
highlight("BufferLineModifiedVisible", colors.red, colors.black2, nil, nil)
highlight("BufferLineModifiedSelected", colors.green, colors.black, nil, nil)
highlight("BufferLineSeparator", colors.black2, colors.black2, nil, nil)
highlight("BufferLineSeparatorVisible", colors.black2, colors.black2, nil, nil)
highlight("BufferLineSeparatorSelected", colors.black2, colors.black2, nil, nil)
highlight("BufferLineTab", colors.light_grey, colors.one_bg3, nil, nil)
highlight("BufferLineTabSelected", colors.black2, colors.nord_blue, nil, nil)
highlight("BufferLineTabClose", colors.red, colors.black, nil, nil)
-- highlight("BufferLineDevIconDefaultSelected", colors.fg, colors.bg, nil, nil)
-- highlight("BufferLineDevIconDefaultInactive", colors.fg, colors.bg, nil, nil)
highlight("BufferLineDuplicate", colors.fg, colors.black2, nil, nil)
highlight("BufferLineDuplicateSelected", colors.red, colors.black, nil, nil)
highlight("BufferLineDuplicateVisible", colors.blue, colors.black2, nil, nil)
highlight("BufferLineRightCustomAreaText1", colors.white, colors.bg, nil, nil)
highlight("BufferLineRightCustomAreaText2", colors.red, colors.bg, nil, nil)

-- -- Neovim terminal colours
-- if vim.fn.has("nvim") then
--     vim.g.terminal_color_0 = theme.base00
--     vim.g.terminal_color_1 = theme.base08
--     vim.g.terminal_color_2 = theme.base0B
--     vim.g.terminal_color_3 = theme.base0A
--     vim.g.terminal_color_4 = theme.base0D
--     vim.g.terminal_color_5 = theme.base0E
--     vim.g.terminal_color_6 = theme.base0C
--     vim.g.terminal_color_7 = theme.base05
--     vim.g.terminal_color_8 = theme.base03
--     vim.g.terminal_color_9 = theme.base08
--     vim.g.terminal_color_10 = theme.base0B
--     vim.g.terminal_color_11 = theme.base0A
--     vim.g.terminal_color_12 = theme.base0D
--     vim.g.terminal_color_13 = theme.base0E
--     vim.g.terminal_color_14 = theme.base0C
--     vim.g.terminal_color_15 = theme.base07
--     if vim.o.background == "light" then
--         vim.g.terminal_color_background = theme.base05
--         vim.g.terminal_color_foreground = theme.base0B
--     else
--         vim.g.terminal_color_background = theme.base00
--         vim.g.terminal_color_foreground = theme.base0E
--     end
-- end
--
-- Vim editor colors
highlight("MatchWord", colors.white, colors.grey, nil, nil)
highlight("Pmenu", nil, colors.one_bg, nil, nil)
highlight("PmenuSbar", nil, colors.one_bg, nil, nil)
highlight("PmenuSel", colors.black, colors.pmenu_bg, nil, nil)
highlight("PmenuSbar", nil, colors.grey, nil, nil)
highlight("MatchParen", colors.white, colors.grey, nil, nil)

highlight("Normal", theme.base05, theme.base00, nil, nil)
highlight("Bold", nil, nil, "bold", nil)
highlight("Debug", theme.base08, nil, nil, nil)
highlight("Directory", theme.base0D, nil, nil, nil)
highlight("Error", theme.base00, theme.base08, nil, nil)
highlight("ErrorMsg", theme.base08, theme.base00, nil, nil)
highlight("Exception", theme.base08, nil, nil, nil)
highlight("FoldColumn", theme.base0C, theme.base01, nil, nil)
highlight("Folded", theme.base03, theme.base01, nil, nil)
highlight("IncSearch", theme.base01, theme.base09, "none", nil)
highlight("Italic", nil, nil, "none", nil)
highlight("Macro", theme.base08, nil, nil, nil)
highlight("ModeMsg", theme.base0B, nil, nil, nil)
highlight("MoreMsg", theme.base0B, nil, nil, nil)
highlight("Question", theme.base0D, nil, nil, nil)
highlight("Search", theme.base01, theme.base0A, nil, nil)
highlight("Substitute", theme.base01, theme.base0A, "none", nil)
highlight("SpecialKey", theme.base03, nil, nil, nil)
highlight("TooLong", theme.base08, nil, nil, nil)
highlight("Underlined", theme.base08, nil, nil, nil)
highlight("Visual", nil, theme.base02, nil, nil)
highlight("VisualNOS", theme.base08, nil, nil, nil)
highlight("WarningMsg", theme.base08, nil, nil, nil)
highlight("WildMenu", theme.base08, theme.base0A, nil, nil)
highlight("Title", theme.base0D, nil, "none", nil)
highlight("Conceal", theme.base0D, theme.base00, nil, nil)
highlight("Cursor", theme.base00, theme.base05, nil, nil)
highlight("NonText", theme.base03, nil, nil, nil)
highlight("LineNr", colors.grey, "NONE", nil, nil)
highlight("SignColumn", theme.base03, "NONE", nil, nil)
highlight("StatusLine", theme.base04, "NONE", "none", nil)
highlight("StatusLineNC", theme.base03, "NONE", "none", nil)
highlight("VertSplit", colors.line, "NONE", "none", nil)
highlight("ColorColumn", nil, theme.base01, "none", nil)
highlight("CursorColumn", nil, theme.base01, "none", nil)
highlight("CursorLineNr", colors.white, "NONE", nil, nil)
highlight("QuickFixLine", nil, theme.base01, "none", nil)
highlight("TabLine", theme.base03, theme.base01, "none", nil)
highlight("TabLineFill", theme.base03, theme.base01, "none", nil)
highlight("TabLineSel", theme.base0B, theme.base01, "none", nil)
highlight("FloatBorder", colors.blue, nil, "none", nil)
highlight("NormalFloat", nil, colors.darker_black, "none", nil)
highlight("NvimInternalError", colors.red, nil, "none", nil)
--
-- -- Standard syntax highlighting
highlight("Boolean", theme.base09, nil, nil, nil)
highlight("Character", theme.base08, nil, nil, nil)
highlight("Comment", colors.grey_fg, nil, nil, nil)
highlight("Conditional", theme.base0E, nil, nil, nil)
highlight("Constant", theme.base09, nil, nil, nil)
highlight("Define", theme.base0E, nil, "none", nil)
highlight("Delimiter", theme.base0F, nil, nil, nil)
highlight("Float", theme.base09, nil, nil, nil)
highlight("Variable", theme.base05, nil, nil, nil)
highlight("Function", theme.base0D, nil, nil, nil)
highlight("Identifier", theme.base08, nil, "none", nil)
highlight("Include", theme.base0D, nil, nil, nil)
highlight("Keyword", theme.base0E, nil, nil, nil)
highlight("Label", theme.base0A, nil, nil, nil)
highlight("Number", theme.base09, nil, nil, nil)
highlight("Operator", theme.base05, nil, "none", nil)
highlight("PreProc", theme.base0A, nil, nil, nil)
highlight("Repeat", theme.base0A, nil, nil, nil)
highlight("Special", theme.base0C, nil, nil, nil)
highlight("SpecialChar", theme.base0F, nil, nil, nil)
highlight("Statement", theme.base08, nil, nil, nil)
highlight("StorageClass", theme.base0A, nil, nil, nil)
highlight("String", theme.base0B, nil, nil, nil)
highlight("Structure", theme.base0E, nil, nil, nil)
highlight("Tag", theme.base0A, nil, nil, nil)
highlight("Todo", theme.base0A, theme.base01, nil, nil)
highlight("Type", theme.base0A, nil, "none", nil)
highlight("Typedef", theme.base0A, nil, nil, nil)

-- Git
highlight("GitSignsAdd", colors.blue, "NONE", nil, nil)
highlight("GitSignsChange", colors.light_grey, "NONE", nil, nil)
highlight("GitSignsDelete", colors.red, "NONE", nil, nil)
highlight("GitSignsChangeDelete", colors.purple, "NONE", nil, nil)
highlight("DiffAdd", colors.blue, nil, nil, nil)
highlight("DiffChange", colors.light_grey, nil, nil, nil)
highlight("DiffDelete", colors.red, nil, nil, nil)
highlight("DiffText", colors.purple, nil, nil, nil)

-- LspDiagnostics
highlight("DiagnosticError", colors.red, nil, nil, nil)
highlight("DiagnosticWarn", colors.yellow, nil, nil, nil)
highlight("DiagnosticInfo", colors.blue, nil, nil, nil)
highlight("DiagnosticHint", colors.purple, nil, nil, nil)
highlight("LspReferenceText", colors.darker_black, colors.white, nil, nil)
highlight("LspReferenceRead", colors.darker_black, colors.white, nil, nil)
highlight("LspReferenceWrite", colors.darker_black, colors.white, nil, nil)

-- -- Additional Tree-sitter highlighting
-- highlight("TSNote", theme.base0D, nil, nil, nil)
-- highlight("TSWarning", theme.base0A, nil, nil, nil)
-- highlight("TSDanger", theme.base08, nil, nil, nil)
-- highlight("TSConstructor", theme.base08, nil, nil, nil)
-- highlight("TSConstant", theme.base09, nil, nil, nil)
-- highlight("TSField", theme.base05, nil, nil, nil)
-- highlight("TSInclude", theme.base0E, nil, nil, nil)
-- highlight("TSKeyword", theme.base09, nil, nil, nil)
-- highlight("TSLabel", theme.base0A, nil, nil, nil)
-- highlight("TSNamespace", theme.base05, nil, nil, nil)
-- highlight("TSOperator", theme.base05, nil, nil, nil)
-- highlight("TSParameter", theme.base08, nil, nil, nil)
-- highlight("TSProperty", theme.base0C, nil, nil, nil)
-- highlight("TSPunctDelimiter", theme.base05, nil, nil, nil)
-- highlight("TSPunctBracket", theme.base05, nil, nil, nil)
-- highlight("TSPunctSpecial", theme.base05, nil, nil, nil)
-- highlight("TSStringRegex", theme.base08, nil, nil, nil)
-- highlight("TSStringEscape", theme.base0F, nil, nil, nil)
-- highlight("TSType", theme.base0E, nil, nil, nil)
-- highlight("TSVariable", theme.base08, nil, nil, nil)
-- highlight("TSTag", theme.base0A, nil, nil, nil)
-- highlight("TSVariableBuiltin", theme.base0A, nil, nil, nil)
--
-- ---
-- -- Extra definitions
-- ---
--
-- -- C highlighting
-- highlight("cOperator", theme.base0C, nil, nil, nil)
-- highlight("cPreCondit", theme.base0E, nil, nil, nil)
--
-- -- C# highlighting
-- highlight("csClass", theme.base0A, nil, nil, nil)
-- highlight("csAttribute", theme.base0A, nil, nil, nil)
-- highlight("csModifier", theme.base0E, nil, nil, nil)
-- highlight("csType", theme.base08, nil, nil, nil)
-- highlight("csUnspecifiedStatement", theme.base0D, nil, nil, nil)
-- highlight("csContextualStatement", theme.base0E, nil, nil, nil)
-- highlight("csNewDecleration", theme.base08, nil, nil, nil)
--
-- -- CSS highlighting
-- highlight("cssBraces", theme.base05, nil, nil, nil)
-- highlight("cssClassName", theme.base0E, nil, nil, nil)
-- highlight("cssColor", theme.base0C, nil, nil, nil)
--
-- -- Diff highlighting
-- highlight("DiffAdd", theme.base0B, theme.base01, nil, nil)
-- highlight("DiffChange", theme.base03, theme.base01, nil, nil)
-- highlight("DiffDelete", theme.base08, theme.base01, nil, nil)
-- highlight("DiffText", theme.base0D, theme.base01, nil, nil)
-- highlight("DiffAdded", theme.base0B, theme.base00, nil, nil)
-- highlight("DiffFile", theme.base08, theme.base00, nil, nil)
-- highlight("DiffNewFile", theme.base0B, theme.base00, nil, nil)
-- highlight("DiffLine", theme.base0D, theme.base00, nil, nil)
-- highlight("DiffRemoved", theme.base08, theme.base00, nil, nil)
--
-- -- Git highlighting
-- highlight("gitcommitOverflow", theme.base08, nil, nil, nil)
-- highlight("gitcommitSummary", theme.base0B, nil, nil, nil)
-- highlight("gitcommitComment", theme.base03, nil, nil, nil)
-- highlight("gitcommitUntracked", theme.base03, nil, nil, nil)
-- highlight("gitcommitDiscarded", theme.base03, nil, nil, nil)
-- highlight("gitcommitSelected", theme.base03, nil, nil, nil)
-- highlight("gitcommitHeader", theme.base0E, nil, nil, nil)
-- highlight("gitcommitSelectedType", theme.base0D, nil, nil, nil)
-- highlight("gitcommitUnmergedType", theme.base0D, nil, nil, nil)
-- highlight("gitcommitDiscardedType", theme.base0D, nil, nil, nil)
-- highlight("gitcommitBranch", theme.base09, nil, "bold", nil)
-- highlight("gitcommitUntrackedFile", theme.base0A, nil, nil, nil)
-- highlight("gitcommitUnmergedFile", theme.base08, nil, "bold", nil)
-- highlight("gitcommitDiscardedFile", theme.base08, nil, "bold", nil)
-- highlight("gitcommitSelectedFile", theme.base0B, nil, "bold", nil)
--
-- -- HTML highlighting
-- highlight("htmlBold", theme.base0A, nil, nil, nil)
-- highlight("htmlItalic", theme.base0E, nil, nil, nil)
-- highlight("htmlEndTag", theme.base05, nil, nil, nil)
-- highlight("htmlTag", theme.base05, nil, nil, nil)
--
-- -- JavaScript highlighting
-- highlight("javaScript", theme.base05, nil, nil, nil)
-- highlight("javaScriptBraces", theme.base05, nil, nil, nil)
-- highlight("javaScriptNumber", theme.base09, nil, nil, nil)
-- -- pangloss/vim-javascript highlighting
-- highlight("jsOperator", theme.base0D, nil, nil, nil)
-- highlight("jsStatement", theme.base0E, nil, nil, nil)
-- highlight("jsReturn", theme.base0E, nil, nil, nil)
-- highlight("jsThis", theme.base08, nil, nil, nil)
-- highlight("jsClassDefinition", theme.base0A, nil, nil, nil)
-- highlight("jsFunction", theme.base0E, nil, nil, nil)
-- highlight("jsFuncName", theme.base0D, nil, nil, nil)
-- highlight("jsFuncCall", theme.base0D, nil, nil, nil)
-- highlight("jsClassFuncName", theme.base0D, nil, nil, nil)
-- highlight("jsClassMethodType", theme.base0E, nil, nil, nil)
-- highlight("jsRegexpString", theme.base0C, nil, nil, nil)
-- highlight("jsGlobalObjects", theme.base0A, nil, nil, nil)
-- highlight("jsGlobalNodeObjects", theme.base0A, nil, nil, nil)
-- highlight("jsExceptions", theme.base0A, nil, nil, nil)
-- highlight("jsBuiltins", theme.base0A, nil, nil, nil)
--
-- -- Mail highlighting
-- highlight("mailQuoted1", theme.base0A, nil, nil, nil)
-- highlight("mailQuoted2", theme.base0B, nil, nil, nil)
-- highlight("mailQuoted3", theme.base0E, nil, nil, nil)
-- highlight("mailQuoted4", theme.base0C, nil, nil, nil)
-- highlight("mailQuoted5", theme.base0D, nil, nil, nil)
-- highlight("mailQuoted6", theme.base0A, nil, nil, nil)
-- highlight("mailURL", theme.base0D, nil, nil, nil)
-- highlight("mailEmail", theme.base0D, nil, nil, nil)
--
-- -- Markdown highlighting
-- highlight("markdownCode", theme.base0B, nil, nil, nil)
-- highlight("markdownError", theme.base05, theme.base00, nil, nil)
-- highlight("markdownCodeBlock", theme.base0B, nil, nil, nil)
-- highlight("markdownHeadingDelimiter", theme.base0D, nil, nil, nil)
--
-- -- PHP highlighting
-- highlight("phpMemberSelector", theme.base05, nil, nil, nil)
-- highlight("phpComparison", theme.base05, nil, nil, nil)
-- highlight("phpParent", theme.base05, nil, nil, nil)
-- highlight("phpMethodsVar", theme.base0C, nil, nil, nil)
--
-- -- Python highlighting
-- highlight("pythonOperator", theme.base0E, nil, nil, nil)
-- highlight("pythonRepeat", theme.base0E, nil, nil, nil)
-- highlight("pythonInclude", theme.base0E, nil, nil, nil)
-- highlight("pythonStatement", theme.base0E, nil, nil, nil)
--
-- -- Ruby highlighting
-- highlight("rubyAttribute", theme.base0D, nil, nil, nil)
-- highlight("rubyConstant", theme.base0A, nil, nil, nil)
-- highlight("rubyInterpolationDelimiter", theme.base0F, nil, nil, nil)
-- highlight("rubyRegexp", theme.base0C, nil, nil, nil)
-- highlight("rubySymbol", theme.base0B, nil, nil, nil)
-- highlight("rubyStringDelimiter", theme.base0B, nil, nil, nil)
--
-- -- SASS highlighting
-- highlight("sassidChar", theme.base08, nil, nil, nil)
-- highlight("sassClassChar", theme.base09, nil, nil, nil)
-- highlight("sassInclude", theme.base0E, nil, nil, nil)
-- highlight("sassMixing", theme.base0E, nil, nil, nil)
-- highlight("sassMixinName", theme.base0D, nil, nil, nil)
--
-- -- Spelling highlighting
-- highlight("SpellBad", nil, nil, "undercurl", theme.base08)
-- highlight("SpellLocal", nil, nil, "undercurl", theme.base0C)
-- highlight("SpellCap", nil, nil, "undercurl", theme.base0D)
-- highlight("SpellRare", nil, nil, "undercurl", theme.base0E)
--
-- -- Java highlighting
-- highlight("javaOperator", theme.base0D, nil, nil, nil)
--
-- -- Telescope
-- highlight("TelescopeBorder", theme.base0D, nil, nil, nil)
-- highlight("TelescopePromptBorder", theme.base0D, nil, nil, nil)
-- highlight("TelescopeResultsBorder", theme.base0D, nil, nil, nil)
-- highlight("TelescopePreviewBorder", theme.base0D, nil, nil, nil)
--
-- nvim-cmp
highlight("CmpItemAbbr", colors.white, nil, nil, nil)
highlight("CmpItemAbbrMatch", colors.blue, nil, "bold", nil)
highlight("CmpBorder", colors.grey, nil, nil, nil)
highlight("CmpDocBorder", colors.darker_black, colors.darker_black, nil, nil)
highlight("CmpPmenu", nil, colors.darker_black, nil, nil)
highlight("CmpItemAbbrMatchFuzzy", theme.base0C, nil, nil, nil)
highlight("CmpItemKindConstant", theme.base09, nil, nil, nil)
highlight("CmpItemKindFunction", theme.base0D, nil, nil, nil)
highlight("CmpItemKindIdentifier", theme.base08, nil, nil, nil)
highlight("CmpItemKindField", theme.base08, nil, nil, nil)
highlight("CmpItemKindVariable", theme.base0E, nil, nil, nil)
highlight("CmpItemKindSnippet", colors.red, nil, nil, nil)
highlight("CmpItemKindText", theme.base0B, nil, nil, nil)
highlight("CmpItemKindStructure", theme.base0E, nil, nil, nil)
highlight("CmpItemKindType", theme.base0A, nil, nil, nil)
highlight("CmpItemKindKeyword", theme.base07, nil, nil, nil)
highlight("CmpItemKindMethod", theme.base0D, nil, nil, nil)
highlight("CmpItemKindConstructor", colors.blue, nil, nil, nil)
highlight("CmpItemKindFolder", theme.base07, nil, nil, nil)
highlight("CmpItemKindModule", theme.base0A, nil, nil, nil)
highlight("CmpItemKindProperty", theme.base08, nil, nil, nil)
highlight("CmpItemKindUnit", theme.base0E, nil, nil, nil)
highlight("CmpItemKindFile", theme.base07, nil, nil, nil)
highlight("CmpItemKindColor", colors.red, nil, nil, nil)
highlight("CmpItemKindReference", theme.base05, nil, nil, nil)
highlight("CmpItemKindStruct", theme.base0E, nil, nil, nil)
highlight("CmpItemKindOperator", theme.base05, nil, nil, nil)
highlight("CmpItemKindTypeParameter", theme.base08, nil, nil, nil)
--
-- Fixed color highlighting
-- require("core.highlights")

highlight("TSAnnotation", theme.base0F, nil, nil, nil)
highlight("TSAttribute", theme.base0A, nil, nil, nil)
highlight("TSCharacter", theme.base08, nil, nil, nil)
highlight("TSConstructor", theme.base0C, nil, nil, nil)
highlight("TSConstBuiltin", theme.base09, nil, nil, nil)
highlight("TSConstMacro", theme.base08, nil, nil, nil)
highlight("TSError", theme.base08, nil, nil, nil)
highlight("TSException", theme.base08, nil, nil, nil)
highlight("TSFloat", theme.base09, nil, nil, nil)
highlight("TSKeyword", theme.base0E, nil, nil, nil)
highlight("TSKeywordFunction", theme.base0E, nil, nil, nil)
highlight("TSKeywordReturn", theme.base0E, nil, nil, nil)
highlight("TSFunction", theme.base0D, nil, nil, nil)
highlight("TSFuncBuiltin", theme.base0D, nil, nil, nil)
highlight("TSFuncMacro", theme.base08, nil, nil, nil)
highlight("TSKeywordOperator", theme.base0E, nil, nil, nil)
highlight("TSMethod", theme.base0D, nil, nil, nil)
highlight("TSNamespace", theme.base08, nil, nil, nil)
highlight("TSNone", theme.base05, nil, nil, nil)
highlight("TSParameter", theme.base08, nil, nil, nil)
highlight("TSParameterReference", theme.base05, nil, nil, nil)
highlight("TSPunctBracket", theme.base0F, nil, nil, nil)
highlight("TSPunctDelimiter", theme.base0F, nil, nil, nil)
highlight("TSPunctSpecial", theme.base08, nil, nil, nil)
highlight("TSStringRegex", theme.base0C, nil, nil, nil)
highlight("TSStringEscape", theme.base0C, nil, nil, nil)
highlight("TSSymbol", theme.base0B, nil, nil, nil)
highlight("TSTagDelimiter", theme.base0F, nil, nil, nil)
highlight("TSText", theme.base05, nil, nil, nil)
highlight("TSEmphasis", theme.base09, nil, nil, nil)
highlight("TSStrike", theme.base00, nil, nil, nil)
highlight("TSLiteral", theme.base09, nil, nil, nil)
highlight("TSURI", theme.base09, nil, nil, nil)
highlight("TSTypeBuiltin", theme.base0A, nil, nil, nil)
highlight("TSVariableBuiltin", theme.base09, nil, nil, nil)
highlight("TSVariable", theme.base05, nil, nil, nil)
highlight("TSDefinition", theme.base04, nil, nil, nil)
highlight("TSDefinitionUsage", theme.base04, nil, nil, nil)
highlight("luaTSField", theme.base0D, nil, nil, nil)
highlight("TSFieldKey", theme.base08, nil, nil, nil)
highlight("TSProperty", theme.base08, nil, nil, nil)

highlight("WhichKey", colors.blue, nil, nil, nil)
highlight("WhichKeySeperator", colors.light_grey, nil, nil, nil)
highlight("WhichKeyDesc", colors.red, nil, nil, nil)
highlight("WhichKeyGroup", colors.green, nil, nil, nil)
highlight("WhichKeyValue", colors.green, nil, nil, nil)

highlight("NvimTreeEmptyFolderName", colors.folder_bg, nil, nil, nil)
highlight("NvimTreeEndOfBuffer", colors.darker_black, nil, nil, nil)
highlight("NvimTreeFolderIcon", colors.folder_bg, nil, nil, nil)
highlight("NvimTreeFolderName", colors.folder_bg, nil, nil, nil)
highlight("NvimTreeGitDirty", colors.red, nil, nil, nil)
highlight("NvimTreeIndentMarker", colors.grey_fg, nil, nil, nil)
highlight("NvimTreeOpenedFolderName", colors.folder_bg, nil, nil, nil)
highlight("NvimTreeGitIgnored", colors.light_grey, nil, nil, nil)
highlight("NvimTreeNormal", nil, colors.darker_black, nil, nil)
highlight("NvimTreeNormalNC", nil, colors.darker_black, nil, nil)
