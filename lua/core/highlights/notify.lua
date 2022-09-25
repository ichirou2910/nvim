local colors = require("themes." .. vim.g.nv_theme).base_30

return {
    NotifyERRORTitle = { fg = "#f7768e", bg = nil },
    NotifyERRORBorder = { fg = "#f7768e", bg = nil },
    NotifyERRORIcon = { fg = "#f7768e", bg = nil },
    NotifyWARNTitle = { fg = "#e0af68", bg = nil },
    NotifyWARNBorder = { fg = "#e0af68", bg = nil },
    NotifyWARNIcon = { fg = "#e0af68", bg = nil },
    NotifyINFOTitle = { fg = "#7dcfff", bg = nil },
    NotifyINFOBorder = { fg = "#7dcfff", bg = nil },
    NotifyINFOIcon = { fg = "#7dcfff", bg = nil },
    NotifyDEBUGTitle = { fg = "#8B8B8B", bg = nil },
    NotifyDEBUGBorder = { fg = "#8B8B8B", bg = nil },
    NotifyDEBUGIcon = { fg = "#8B8B8B", bg = nil },
    NotifyTRACETitle = { fg = "#D484FF", bg = nil },
    NotifyTRACEBorder = { fg = "#4F3552", bg = nil },
    NotifyTRACEIcon = { fg = "#D484FF", bg = nil },
    NotifyERRORBody = { link = "Normal" },
    NotifyWARNBody = { link = "Normal" },
    NotifyINFOBody = { link = "Normal" },
    NotifyDEBUGBody = { link = "Normal" },
    NotifyTRACEBody = { link = "Normal" },
}
