local ok, lualine = pcall(require, "lualine")
if not ok then
    return
end
local icons = require("core.ui.icons")

-- Extensions
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

local function obsession_status()
    return vim.fn.ObsessionStatus(" ", "")
end

local function cwd_name()
    local t = {}
    for str in string.gmatch(vim.fn.getcwd(), "([^" .. "/" .. "]+)") do
        table.insert(t, str)
    end
    return " " .. t[#t]
end

lualine.setup({
    options = {
        theme = "tokyonight",
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
        lualine_x = { { obsession_status }, "encoding", "fileformat", "filetype" },
    },
    extensions = {
        "fugitive",
        "nvim-tree",
        "symbols-outline",
        "quickfix",
        notes,
        gitcommit,
    },
})
