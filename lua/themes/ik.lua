local M = {}

M.base_30 = {
    white = "#d9e0ee",
    darker_black = "#191828",
    black = "#1e1d2d", --  nvim bg
    black2 = "#252434",
    one_bg = "#2d2c3c", -- real bg of onedark
    one_bg2 = "#363545",
    one_bg3 = "#3e3d4d",
    grey = "#474656",
    grey_fg = "#4e4d5d",
    grey_fg2 = "#8b949e",
    light_grey = "#605f6f",
    red = "#f38ba8",
    baby_pink = "#ffa5c3",
    pink = "#f5c2e7",
    line = "#383747", -- for lines like vertsplit
    green = "#37d99e",
    vibrant_green = "#b6f4be",
    nord_blue = "#8bc2f0",
    blue = "#89b4fa",
    yellow = "#fae3b0",
    sun = "#ffe9b6",
    purple = "#d0a9e5",
    dark_purple = "#c7a0dc",
    teal = "#1abc9c",
    orange = "#ff9e64",
    cyan = "#89dceb",
    statusline_bg = "#232232",
    lightbg = "#2f2e3e",
    pmenu_bg = "#5fb0fc",
    folder_bg = "#89b4fa",
    lavender = "#c7d1ff",
    float_bg = "#191828",
}

M.base_16 = {
    base00 = "#1e1d2d",
    base01 = "#282737",
    base02 = "#2f2e3e",
    base03 = "#383747",
    base04 = "#414050",
    base05 = "#bfc6d4",
    base06 = "#ccd3e1",
    base07 = "#d9e0ee",
    base08 = "#1abc9c",
    base09 = "#f0a988",
    base0A = "#e5d487",
    base0B = "#f38ba8",
    base0C = "#37d99e",
    base0D = "#5fb0fc",
    base0E = "#9d7cd8",
    base0F = "#e87979",
}

M.override = {
    ["@variable"] = { fg = M.base_16.base08 },
    ["@field"] = { fg = M.base_30.cyan },
    ["@property"] = { fg = M.base_30.teal },
    ["@variable.builtin"] = { fg = M.base_30.red },
}

return M
