vim.o.laststatus = 0
vim.opt.number = true
vim.opt.rnu = true
vim.opt.background = "light"
vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
vim.g.firenvim_config = {
    globalSettings = {
        alt = "all",
    },
    localSettings = {
        [".*"] = {
            cmdline = "neovim",
            content = "text",
            priority = 0,
            selector = "textarea",
            takeover = "never",
        },
    },
}
vim.opt.signcolumn = "no"
vim.opt.foldcolumn = "0"

vim.cmd([[
    augroup firenvim
        autocmd!
        autocmd BufEnter github.com_*.txt set filetype=markdown
        autocmd BufEnter stackoverflow.com_*.txt set filetype=markdown
        autocmd BufRead mermaid.live*.txt set filetype=mermaid
    augroup END
]])

vim.api.nvim_set_hl(0, "CursorLine", { bg = "#252434", default = false })
vim.api.nvim_set_hl(0, "Visual", { bg = "#2f2e3e", default = false })
