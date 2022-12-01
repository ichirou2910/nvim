local isEmpty = require("core.utils").isEmpty

local M = {}

M.winbar_filetype_exclude = {
    "help",
    "dbui",
    "packer",
    "fugitive",
    "NvimTree",
    "Trouble",
    "spectre_panel",
    "toggleterm",
    "",
}

M.filename = function()
    local filename = vim.fn.expand("%:t")
    local extension = ""
    local file_icon = ""
    local file_icon_color = ""
    local default_file_icon = ""
    local default_file_icon_color = ""

    if not isEmpty(filename) then
        extension = vim.fn.expand("%:e")

        file_icon, file_icon_color =
            require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })

        local hl_group = "FileIconColor" .. extension

        vim.api.nvim_set_hl(0, hl_group, { fg = file_icon_color })
        if file_icon == nil then
            file_icon = default_file_icon
            file_icon_color = default_file_icon_color
        end

        return " " .. "%#" .. hl_group .. "#" .. file_icon .. "%*" .. " " .. filename .. "%m"
    end
end

M.get = function()
    local status_ok, navic = pcall(require, "nvim-navic")
    if not status_ok then
        return
    end

    local icons = require("core.ui.icons")

    local filename = M.filename()
    local navic_data = navic.get_location()

    if navic.is_available() then
        return filename .. " " .. icons.ui.ChevronRight .. " " .. navic_data
    else
        if not vim.tbl_contains(M.winbar_filetype_exclude, vim.bo.filetype) then
            return filename
        end
        return navic_data
    end
end

_G.navic_location = function()
    return require("core.ui.winbar").get()
end
vim.o.winbar = "%{%v:lua.navic_location()%}"

return M
