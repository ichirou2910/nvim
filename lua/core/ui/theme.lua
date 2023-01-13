-- Activate highlighting
vim.api.nvim_command("syntax on")
if vim.fn.has("termguicolors") == 1 then
    vim.o.termguicolors = true
end

-- Available themes
vim.g.nv_theme = "ik"

require("core.utils").highlight_group("general")
