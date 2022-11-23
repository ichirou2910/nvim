local M = {}

M.custom_border = function(hl_name)
    if M.isEmpty(hl_name) then
        return { "", "", "", "", "", "", "", "" }
    end
    return {
        { "", hl_name },
        { "", hl_name },
        { "", hl_name },
        { "", hl_name },
        { "", hl_name },
        { "", hl_name },
        { "", hl_name },
        { "", hl_name },
    }
end

M.keymap = function(mode, keys, cmd, opt)
    local options = { noremap = true, silent = true }
    if opt then
        options = vim.tbl_extend("force", options, opt)
    end

    -- all valid modes allowed for mappings
    -- :h map-modes
    local valid_modes = {
        [""] = true,
        ["n"] = true,
        ["v"] = true,
        ["s"] = true,
        ["x"] = true,
        ["o"] = true,
        ["!"] = true,
        ["i"] = true,
        ["l"] = true,
        ["c"] = true,
        ["t"] = true,
    }

    -- helper function for M.map
    -- can gives multiple modes and keys
    local function map_wrapper(_mode, lhs, rhs, _options)
        if type(lhs) == "table" then
            for _, key in ipairs(lhs) do
                map_wrapper(_mode, key, rhs, _options)
            end
        else
            if type(_mode) == "table" then
                for _, m in ipairs(_mode) do
                    map_wrapper(m, lhs, rhs, _options)
                end
            else
                if valid_modes[_mode] and lhs and rhs then
                    vim.api.nvim_set_keymap(_mode, lhs, rhs, _options)
                else
                    _mode, lhs, rhs = _mode or "", lhs or "", rhs or ""
                    print(
                        "Cannot set mapping [ mode = '"
                            .. _mode
                            .. "' | key = '"
                            .. lhs
                            .. "' | cmd = '"
                            .. rhs
                            .. "' ]"
                    )
                end
            end
        end
    end

    map_wrapper(mode, keys, cmd, options)
end

M.highlight = function(group, hl_table)
    vim.api.nvim_set_hl(0, group, hl_table)
end

M.highlight_group = function(group)
    if vim.g.nv_theme == "" then
        return
    end

    if type(group) == "string" then
        group = require("core.highlights." .. group)
    end

    local override_hl = require("themes." .. vim.g.nv_theme).override
    if override_hl then
        for key, value in pairs(override_hl) do
            if group[key] then
                group[key] = vim.tbl_deep_extend("force", group[key], value)
            end
        end
    end

    for hl, col in pairs(group) do
        vim.api.nvim_set_hl(0, hl, col)
    end
end

-- Convert target to string
M.toString = function(src)
    if type(src) == "table" then
        local s = "{ "
        for k, v in pairs(src) do
            if type(k) ~= "number" then
                k = '"' .. k .. '"'
            end
            s = s .. "[" .. k .. "] = " .. M.toString(v) .. ","
        end
        return s .. "} "
    else
        return tostring(src)
    end
end

M.isEmpty = function(src)
    return src == nil or src == ""
end

return M
