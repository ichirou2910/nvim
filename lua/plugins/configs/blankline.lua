vim.cmd([[
    if &diff
        let g:indent_blankline_enabled = v:false
    endif
]])

vim.cmd([[highlight IndentBlanklineContextChar guifg=#C678DD gui=nocombine]])
vim.cmd([[highlight IndentBlanklineContextStart guisp=#C678DD gui=underline]])

require("indent_blankline").setup({
    viewport_buffer = 100,
    char = "▏", -- '│'
    context_char = "▏", -- '│'
    filetype_exclude = {
        "vimwiki",
        "man",
        "diagnosticpopup",
        "lspinfo",
        "packer",
        "markdown",
        "TelescopePrompt",
        "TelescopeResults",
        "WhichKey",
        "",
    },
    space_char_blankline = " ",
    use_treesitter = true,
    show_current_context = true,
    show_current_context_start = true,
    show_trailing_blankline_indent = false,
    show_first_indent_level = false,
    show_foldtext = false,
    strict_tabs = true,
    max_indent_increase = 1,
})
