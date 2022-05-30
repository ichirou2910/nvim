local highlight = require("core.utils").highlight

-- misc --
-- highlight("Comment", "#676a71", nil, nil, nil)
-- highlight("NvimInternalError", colors.red, nil, nil, nil)
-- highlight("EndOfBuffer", "#1e222a", nil, nil, nil)
-- highlight("NormalFloat", "NONE", nil, nil, nil)
-- highlight("MatchParen", nil, nil, "bold", nil)
-- highlight("TODO", nil, "#282c34", "bold", nil)
-- highlight("CursorLine", nil, "none", nil, nil)
-- highlight("CursorLineNR", "#ffffff", "none", "bold", nil)
highlight("VertSplit", "#3b4261", "none", nil, nil)

-- notify --
highlight("NotifyERRORTitle", "#f7768e", "none", nil, nil)
highlight("NotifyERRORBorder", "#f7768e", "none", nil, nil)
highlight("NotifyERRORIcon", "#f7768e", "none", nil, nil)

highlight("NotifyWARNTitle", "#e0af68", "none", nil, nil)
highlight("NotifyWARNBorder", "#e0af68", "none", nil, nil)
highlight("NotifyWARNIcon", "#e0af68", "none", nil, nil)

highlight("NotifyINFOTitle", "#7dcfff", "none", nil, nil)
highlight("NotifyINFOBorder", "#7dcfff", "none", nil, nil)
highlight("NotifyINFOIcon", "#7dcfff", "none", nil, nil)

highlight("NotifyDEBUGTitle", "#8B8B8B", "none", nil, nil)
highlight("NotifyDEBUGBorder", "#8B8B8B", "none", nil, nil)
highlight("NotifyDEBUGIcon", "#8B8B8B", "none", nil, nil)

highlight("NotifyTRACETitle", "#D484FF", "none", nil, nil)
highlight("NotifyTRACEBorder", "#4F3552", "none", nil, nil)
highlight("NotifyTRACEIcon", "#D484FF", "none", nil, nil)

-- blankline
-- highlight("IndentBlanklineChar", "#2a2e36", nil, nil, nil)

-- Git
-- highlight("GitSignsAdd", colors.green, "NONE", nil, nil)
-- highlight("GitSignsChange", colors.blue, "NONE", nil, nil)
-- highlight("GitSignsDelete", colors.red, "NONE", nil, nil)
-- highlight("GitSignsChangeDelete", colors.purple, "NONE", nil, nil)
-- highlight("DiffAdd", colors.green, nil, nil, nil)
-- highlight("DiffChange", colors.blue, nil, nil, nil)
-- highlight("DiffDelete", colors.red, nil, nil, nil)
-- highlight("DiffText", colors.purple, nil, nil, nil)

-- LspDiagnostics
-- highlight("DiagnosticError", "#b81212", nil, nil, nil)
-- highlight("DiagnosticWarn", "#907c25", nil, nil, nil)
-- highlight("DiagnosticInfo", colors.blue, nil, nil, nil)
-- highlight("DiagnosticHint", colors.green, nil, nil, nil)