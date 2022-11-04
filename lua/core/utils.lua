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

M.notify = {
    spinner_frames = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" },
    client_notifs = {},
    get_notif_data = function(client_id, token)
        if not M.notify.client_notifs[client_id] then
            M.notify.client_notifs[client_id] = {}
        end

        if not M.notify.client_notifs[client_id][token] then
            M.notify.client_notifs[client_id][token] = {}
        end

        return M.notify.client_notifs[client_id][token]
    end,

    update_spinner = function(client_id, token)
        local notif_data = M.notify.get_notif_data(client_id, token)

        if notif_data.spinner then
            local new_spinner = (notif_data.spinner + 1) % #M.notify.spinner_frames
            notif_data.spinner = new_spinner

            notif_data.notification = vim.notify(nil, nil, {
                hide_from_history = true,
                icon = M.notify.spinner_frames[new_spinner],
                replace = notif_data.notification,
            })

            vim.defer_fn(function()
                M.notify.update_spinner(client_id, token)
            end, 100)
        end
    end,

    format_title = function(title, client_name)
        return client_name .. (#title > 0 and ": " .. title or "")
    end,

    format_message = function(message, percentage)
        return (percentage and percentage .. "%\t" or "") .. (message or "")
    end,
}

return M
