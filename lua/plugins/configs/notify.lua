local status_ok, notify = pcall(require, "notify")

if not status_ok then
    return
end

local api = vim.api
local notify_base = require("notify.render.base")
local utils = require("core.utils")

local function custom_render(bufnr, notif, highlights, config)
    local icon = notif.icon .. " "
    local messages = notif.message

    local title = notif.title[1]
    if utils.isEmpty(title) then
        title = "Global"
    end

    local namespace = notify_base.namespace()

    api.nvim_buf_set_lines(bufnr, 0, #messages - 1, false, messages)
    api.nvim_buf_set_extmark(bufnr, namespace, 0, 0, {
        hl_group = highlights.body,
        end_line = #messages - 1,
        end_col = #messages[#messages],
        priority = 50, -- Allow treesitter to override
    })

    -- title
    api.nvim_buf_set_lines(bufnr, #messages, -1, false, { "" })
    api.nvim_buf_set_extmark(bufnr, namespace, #messages, 0, {
        virt_text = {
            { icon, highlights.icon },
            { title, highlights.title },
        },
        virt_text_pos = "right_align",
        priority = 10,
    })
end

notify.setup({
    render = custom_render,
    stages = "static",

    timeout = 3000,

    background_colour = "#15191e",

    icons = {
        ERROR = "",
        WARN = "",
        INFO = "",
        DEBUG = "",
        TRACE = "",
    },
    on_open = function(win)
        if vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_win_set_config(win, { border = { "", "", "", "", "", "", "", "" } })
        end
    end,
    animate = false,
})

-- default notification provider
--[[ vim.notify = require("notify") ]]

require("core.utils").highlight_group("notify")
