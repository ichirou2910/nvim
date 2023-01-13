vim.cmd([[
    if &diff
        let g:indent_blankline_enabled = v:false
    endif
]])

vim.cmd([[highlight IndentBlanklineContextChar guifg=#f38ba8 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineContextStart0 guisp=#f38ba8 gui=underline]])
vim.cmd([[highlight IndentBlanklineContextStart1 guisp=#ffcb0c gui=underline]])
vim.cmd([[highlight IndentBlanklineContextStart2 guisp=#da70d6 gui=underline]])
vim.cmd([[highlight IndentBlanklineContextStart3 guisp=#179bff gui=underline]])

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
    context_highlight_list = {
        "rainbowcol1",
        "rainbowcol2",
        "rainbowcol3",
    },
    context_start_highlight_list = {
        --[[ "IndentBlanklineContextStart0", ]]
        "IndentBlanklineContextStart1",
        "IndentBlanklineContextStart2",
        "IndentBlanklineContextStart3",
    },
    space_char_blankline = " ",
    use_treesitter = true,
    show_current_context = true,
    show_current_context_start = true,
    show_trailing_blankline_indent = false,
    show_first_indent_level = true,
    show_foldtext = false,
    strict_tabs = true,
    max_indent_increase = 1,
})
