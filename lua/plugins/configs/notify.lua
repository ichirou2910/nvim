local status_ok, notify = pcall(require, "notify")

if not status_ok then
    return
end

local vim_api = vim.api
local notify_base = require("notify.render.base")
local utils = require("core.utils")

local function custom_render(bufnr, notif, highlights, config)
    local icon = notif.icon .. " "
    local messages = notif.message
    for i = 1, #messages do
        messages[i] = "   " .. messages[i] .. " "
    end
    local title = notif.title[1]

    local namespace = notify_base.namespace()

    vim_api.nvim_buf_set_lines(bufnr, 0, #notif.message, false, notif.message)
    vim_api.nvim_buf_set_extmark(bufnr, namespace, 0, 0, {
        virt_text = {
            { " " },
            { icon, highlights.icon },
        },
        virt_text_win_col = 0,
        priority = 10,
    })
    vim_api.nvim_buf_set_extmark(bufnr, namespace, 0, 0, {
        hl_group = highlights.body,
        end_line = #notif.message - 1,
        end_col = #notif.message[#notif.message],
        priority = 10,
    })

    if not utils.isEmpty(title) then
        vim_api.nvim_buf_set_lines(bufnr, #notif.message + 1, -1, false, { "" })
        -- title
        vim_api.nvim_buf_set_extmark(bufnr, namespace, #notif.message, 0, {
            virt_text = {
                { " " },
                { title, highlights.title },
                { " " },
            },
            virt_text_pos = "right_align",
            priority = 10,
        })
    end
end

notify.setup({
    -- Animation style
    -- fade_in_slide_out, slide, static, fade
    stages = "static",
    render = custom_render,

    -- Function called when a new window is opened, use for changing win settings/config
    --[[ on_open = function(win) ]]
    --[[     vim.api.nvim_win_set_config(win, { ]]
    --[[         border = { "╭", "─", "╮", "│", "╯", "", "╰", "│" }, ]]
    --[[     }) ]]
    --[[ end, ]]

    -- Default timeout for notifications
    timeout = 4000,

    -- For stages that change opacity this is treated as the highlight behind the window
    -- Set this to either a highlight group or an RGB hex value e.g. "#000000"
    background_colour = "#15191e",

    -- Icons for the different levels
    icons = {
        ERROR = "",
        WARN = "",
        INFO = "",
        DEBUG = "",
        TRACE = "",
    },
})

-- default notification provider
vim.notify = require("notify")

require("core.utils").highlight_group("notify")
