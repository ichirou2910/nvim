local custom_border = require("core.utils").custom_border

require("toggleterm").setup({
    persist_size = false,
    direction = "float",
    float_opts = {
        border = custom_border("ToggletermBorder"),
        winblend = 0,
    },
    highlights = { NormalFloat = { link = "ToggletermFloat" } },
})

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

---@diagnostic disable-next-line: lowercase-global
function _lazygit_toggle()
    lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>gu", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })

require("core.utils").highlight_group("toggleterm")
