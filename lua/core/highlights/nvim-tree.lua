local theme = require("themes." .. vim.g.nv_theme).base_16
local colors = require("themes." .. vim.g.nv_theme).base_30

return {
    NvimTreeEmptyFolderName = { fg = colors.folder_bg },
    NvimTreeEndOfBuffer = { fg = colors.darker_black },
    NvimTreeFolderIcon = { fg = colors.folder_bg },
    NvimTreeFolderName = { fg = colors.folder_bg },
    NvimTreeGitDirty = { fg = colors.red },
    NvimTreeIndentMarker = { fg = colors.grey_fg },
    NvimTreeOpenedFolderName = { fg = colors.folder_bg },
    NvimTreeGitIgnored = { fg = colors.light_grey },
    NvimTreeNormal = { fg = nil, bg = colors.darker_black },
    NvimTreeNormalNC = { fg = nil, bg = colors.darker_black },
}
