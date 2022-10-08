local colors = require("themes." .. vim.g.nv_theme).base_30
local theme = require("themes." .. vim.g.nv_theme).base_16

return {
    NotifyERRORTitle = { fg = "#f7768e", bg = colors.float_bg },
    NotifyERRORIcon = { fg = "#f7768e", bg = colors.float_bg },

    NotifyWARNTitle = { fg = "#e0af68", bg = colors.float_bg },
    NotifyWARNIcon = { fg = "#e0af68", bg = colors.float_bg },

    NotifyINFOTitle = { fg = "#7dcfff", bg = colors.float_bg },
    NotifyINFOIcon = { fg = "#7dcfff", bg = colors.float_bg },

    NotifyDEBUGTitle = { fg = "#8B8B8B", bg = colors.float_bg },
    NotifyDEBUGIcon = { fg = "#8B8B8B", bg = colors.float_bg },

    NotifyTRACETitle = { fg = "#D484FF", bg = colors.float_bg },
    NotifyTRACEIcon = { fg = "#D484FF", bg = colors.float_bg },

    NotifyERRORBorder = { fg = colors.float_bg, bg = theme.base00 },
    NotifyWARNBorder = { fg = colors.float_bg, bg = theme.base00 },
    NotifyINFOBorder = { fg = colors.float_bg, bg = theme.base00 },
    NotifyDEBUGBorder = { fg = colors.float_bg, bg = theme.base00 },
    NotifyTRACEBorder = { fg = colors.float_bg, bg = theme.base00 },

    NotifyERRORBody = { bg = colors.float_bg },
    NotifyWARNBody = { bg = colors.float_bg },
    NotifyINFOBody = { bg = colors.float_bg },
    NotifyDEBUGBody = { bg = colors.float_bg },
    NotifyTRACEBody = { bg = colors.float_bg },
}
