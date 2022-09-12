local ok, lualine = pcall(require, "lualine")
if not ok then
    return
end
local icons = require("core.ui.icons")
local isEmpty = require("core.utils").isEmpty

local theme_colors = require("themes." .. vim.g.nv_theme).base_30

-- Extensions
local dadbod = {
    sections = {
        lualine_a = {
            function()
                return [[Database]]
            end,
        },
    },
    filetypes = { "dbui" },
}

local notes = {
    sections = {
        lualine_a = {
            function()
                return [[Notes]]
            end,
        },
        lualine_c = { "filename" },
    },
    filetypes = { "notes" },
}

local gitcommit = {
    sections = {
        lualine_a = {
            function()
                local icon = "" -- e0a0
                return icon .. " " .. vim.fn.FugitiveHead()
            end,
        },
        lualine_b = {
            function()
                return [[Commit]]
            end,
        },
    },
    filetypes = { "gitcommit" },
}

local function session_status()
    local name = require("auto-session-library").current_session_name()
    if not isEmpty(name) then
        return " " .. name
    end
    return ""
end

local function cwd_name()
    local t = {}
    for str in string.gmatch(vim.fn.getcwd(), "([^" .. "/" .. "]+)") do
        table.insert(t, str)
    end
    return " " .. t[#t]
end

local radium_theme = {
    normal = {
        a = { bg = theme_colors.blue, fg = theme_colors.black },
        b = { bg = theme_colors.one_bg, fg = theme_colors.blue },
        c = { bg = theme_colors.statusline_bg, fg = theme_colors.white },
    },

    insert = {
        a = { bg = theme_colors.green, fg = theme_colors.black },
        b = { bg = theme_colors.one_bg, fg = theme_colors.green },
    },

    command = {
        a = { bg = theme_colors.yellow, fg = theme_colors.black },
        b = { bg = theme_colors.one_bg, fg = theme_colors.yellow },
    },

    visual = {
        a = { bg = theme_colors.purple, fg = theme_colors.black },
        b = { bg = theme_colors.one_bg, fg = theme_colors.purple },
    },
    replace = {
        a = { bg = theme_colors.red, fg = theme_colors.black },
        b = { bg = theme_colors.one_bg, fg = theme_colors.red },
    },
    inactive = {
        a = { bg = nil, fg = theme_colors.blue },
        b = { bg = nil, fg = theme_colors.one_bg3, gui = "bold" },
        c = { bg = nil, fg = theme_colors.one_bg3 },
    },
}

lualine.setup({
    options = {
        theme = radium_theme,
        globalstatus = true,
        component_separators = { left = icons.ui.SeperatorLeft, right = icons.ui.SeperatorRight },
        section_separators = { left = icons.ui.SeperatorLeftFill, right = icons.ui.SeperatorRightFill },
    },
    sections = {
        lualine_a = { { cwd_name } },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = {
            { "filename", path = 1 },
        },
        lualine_x = { { session_status }, "encoding", "fileformat", "filetype" },
    },
    extensions = {
        "fugitive",
        "nvim-tree",
        "symbols-outline",
        "quickfix",
        dadbod,
        notes,
        gitcommit,
    },
})
