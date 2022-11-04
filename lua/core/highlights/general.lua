local theme = require("themes." .. vim.g.nv_theme).base_16
local colors = require("themes." .. vim.g.nv_theme).base_30

return {
    Normal = { fg = theme.base05, bg = theme.base00 },
    Bold = { bold = true },
    Debug = { fg = theme.base08 },
    Directory = { fg = theme.base0D },
    Error = { fg = theme.base00, bg = theme.base08 },
    ErrorMsg = { fg = theme.base08, bg = theme.base00 },
    Exception = { fg = theme.base08 },
    FoldColumn = { fg = colors.teal, bg = nil },
    Folded = { fg = theme.base03, bg = "#352e51" },
    IncSearch = { fg = theme.base01, bg = theme.base09 },
    Italic = { italic = true },
    Macro = { fg = theme.base08 },
    ModeMsg = { fg = theme.base0B },
    MoreMsg = { fg = colors.white, italic = true },
    Question = { fg = theme.base0D },
    Search = { fg = theme.base01, bg = theme.base0A },
    Substitute = { fg = theme.base01, bg = theme.base0A, sp = "none" },
    SpecialKey = { fg = theme.base03 },
    TooLong = { fg = theme.base08 },
    Underlined = { fg = theme.base08 },
    Visual = { bg = theme.base02 },
    VisualNOS = { fg = theme.base08 },
    WarningMsg = { fg = theme.base08 },
    WildMenu = { fg = theme.base08, bg = theme.base0A },
    Title = { fg = theme.base0D, sp = "none" },
    Conceal = { fg = theme.base0D, bg = theme.base00 },
    Cursor = { fg = theme.base00, bg = theme.base05 },
    NonText = { fg = theme.base03 },
    LineNr = { fg = colors.grey },
    SignColumn = { fg = theme.base03 },
    StatusLine = { fg = theme.base04 },
    StatusLineNC = { fg = theme.base03 },
    VertSplit = { fg = colors.line },
    ColorColumn = { bg = theme.base01 },
    CursorColumn = { bg = theme.base01 },
    CursorLineNr = { fg = colors.white },
    CursorLine = { bg = colors.black2 },
    QuickFixLine = { bg = theme.base01 },
    TabLine = { fg = theme.base03, bg = theme.base01 },
    TabLineFill = { fg = theme.base03, bg = theme.base01 },
    TabLineSel = { fg = theme.base0B, bg = theme.base01 },
    FloatBorder = { fg = colors.float_bg, bg = theme.base00 },
    FloatTitle = { fg = colors.black, bg = colors.green },
    NormalFloat = { bg = colors.float_bg },
    NvimInternalError = { fg = colors.red },
    Boolean = { fg = theme.base09 },
    Character = { fg = theme.base08 },
    Comment = { fg = colors.grey_fg },
    Conditional = { fg = theme.base0E },
    Constant = { fg = theme.base09 },
    Define = { fg = theme.base0E },
    Delimiter = { fg = theme.base0F },
    Float = { fg = theme.base09 },
    Variable = { fg = theme.base05 },
    Function = { fg = theme.base0D },
    Identifier = { fg = theme.base08 },
    Include = { fg = theme.base0D },
    Keyword = { fg = theme.base0E },
    Label = { fg = theme.base0A },
    Number = { fg = theme.base0C },
    Operator = { fg = theme.base05 },
    PreProc = { fg = theme.base0A },
    Repeat = { fg = theme.base0A },
    Special = { fg = theme.base0C },
    SpecialChar = { fg = theme.base0F },
    Statement = { fg = theme.base08 },
    StorageClass = { fg = theme.base0A },
    String = { fg = theme.base0B },
    Structure = { fg = theme.base0E },
    Tag = { fg = theme.base0A },
    Todo = { fg = theme.base0A, bg = theme.base01 },
    Type = { fg = theme.base0A },
    Typedef = { fg = theme.base0A },
    Pmenu = { bg = colors.one_bg },
    PmenuSbar = { bg = colors.one_bg },
    PmenuSel = { fg = colors.black, bg = colors.pmenu_bg },
    PmenuThumb = { fg = colors.black, bg = "#585870" },
    MatchParen = { fg = colors.white, bg = colors.grey },
}
