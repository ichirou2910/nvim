local colors = require("themes." .. vim.g.nv_theme).base_30
local theme = require("themes." .. vim.g.nv_theme).base_16

return {
    NotifyERRORTitle = { fg = "#f7768e", bg = "#24292e" },
    NotifyERRORIcon = { fg = "#f7768e", bg = "#24292e" },

    NotifyWARNTitle = { fg = "#e0af68", bg = "#24292e" },
    NotifyWARNIcon = { fg = "#e0af68", bg = "#24292e" },

    NotifyINFOTitle = { fg = "#7dcfff", bg = "#24292e" },
    NotifyINFOIcon = { fg = "#7dcfff", bg = "#24292e" },

    NotifyDEBUGTitle = { fg = "#8B8B8B", bg = "#24292e" },
    NotifyDEBUGIcon = { fg = "#8B8B8B", bg = "#24292e" },

    NotifyTRACETitle = { fg = "#D484FF", bg = "#24292e" },
    NotifyTRACEIcon = { fg = "#D484FF", bg = "#24292e" },

    NotifyERRORBorder = { fg = theme.base00, bg = theme.base00 },
    NotifyWARNBorder = { fg = theme.base00, bg = theme.base00 },
    NotifyINFOBorder = { fg = theme.base00, bg = theme.base00 },
    NotifyDEBUGBorder = { fg = theme.base00, bg = theme.base00 },
    NotifyTRACEBorder = { fg = theme.base00, bg = theme.base00 },

    NotifyERRORBody = { bg = "#24292e" },
    NotifyWARNBody = { bg = "#24292e" },
    NotifyINFOBody = { bg = "#24292e" },
    NotifyDEBUGBody = { bg = "#24292e" },
    NotifyTRACEBody = { bg = "#24292e" },
}
