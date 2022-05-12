require'toggleterm'.setup {
    persist_size = false,
    direction = 'float',
    float_opts = {
        border = 'curved',
        winblend = 0,
        highlights = {border = "rounded", background = "Normal"}
    }
}

local Terminal = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({cmd = "lazygit", hidden = true})

---@diagnostic disable-next-line: lowercase-global
function _lazygit_toggle() lazygit:toggle() end

vim.api.nvim_set_keymap("n", "<leader>gu", "<cmd>lua _lazygit_toggle()<CR>",
                        {noremap = true, silent = true})
