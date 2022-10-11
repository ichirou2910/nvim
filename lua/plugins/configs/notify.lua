local status_ok, notify = pcall(require, "notify")
local custom_border = require("core.utils").custom_border

if not status_ok then
    return
end

local api = vim.api
local notify_base = require("notify.render.base")
local utils = require("core.utils")
local stages_util = require("notify.stages.util")

local padding = {
    vert = 1,
    hori = 1,
}

local function custom_render(bufnr, notif, highlights, config)
    local icon = notif.icon .. " "
    local messages = notif.message
    local title = notif.title[1]

    local namespace = notify_base.namespace()

    for i = 1, #messages do
        api.nvim_buf_set_lines(bufnr, i - 1, i - 1, false, { "  " .. messages[i] })
        api.nvim_buf_set_extmark(bufnr, namespace, i - 1, 0, {
            hl_group = highlights.body,
            end_line = i - 1,
            end_col = #messages[#messages],
            priority = 50, -- Allow treesitter to override
        })
    end
    api.nvim_buf_set_extmark(bufnr, namespace, 0, 0, {
        virt_text = {
            { icon, highlights.icon },
        },
        virt_text_win_col = 0,
        priority = 10,
    })

    if not utils.isEmpty(title) then
        api.nvim_buf_set_lines(bufnr, #messages, -1, false, { "" })
        -- title
        api.nvim_buf_set_extmark(bufnr, namespace, #messages, 0, {
            virt_text = {
                { title, highlights.title },
                { " " },
            },
            virt_text_pos = "right_align",
            priority = 10,
        })
    end
end

local function custom_stages()
    return {
        function(state)
            local next_height = state.message.height
            local next_row = stages_util.available_slot(state.open_windows, next_height, stages_util.DIRECTION.TOP_DOWN)
            if not next_row then
                return nil
            end
            return {
                relative = "editor",
                anchor = "NE",
                width = state.message.width,
                height = state.message.height,
                col = vim.opt.columns:get() - padding.vert,
                row = next_row,
                border = custom_border("FloatBorder"),

                style = "minimal",
            }
        end,
        function()
            return {
                col = { vim.opt.columns:get() - padding.vert },
                time = true,
            }
        end,
    }
end

notify.setup({
    stages = custom_stages(),
    render = custom_render,

    timeout = 4000,

    background_colour = "#15191e",

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
