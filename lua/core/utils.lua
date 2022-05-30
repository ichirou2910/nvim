local M = {}

M.map = function(mode, keys, cmd, opt)
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

M.highlight = function(group, guifg, guibg, attr, guisp)
    local parts = { group }
    if guifg then
        table.insert(parts, "guifg=" .. guifg)
    end
    if guibg then
        table.insert(parts, "guibg=" .. guibg)
    end
    if attr then
        table.insert(parts, "gui=" .. attr)
    end
    if guisp then
        table.insert(parts, "guisp=#" .. guisp)
    end

    vim.api.nvim_command("highlight " .. table.concat(parts, " "))
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

return M
