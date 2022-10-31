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
    --[[ render = "minimal", ]]
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
-- vim.notify = require("notify")

require("core.utils").highlight_group("notify")
