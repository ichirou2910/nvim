vim.cmd([[
    if &diff
        let g:indent_blankline_enabled = v:false
    endif
]])

vim.cmd([[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]])

require("indent_blankline").setup({
    indentLine_enabled = 1,
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
    context_patterns = {
        "class",
        "function",
        "func_literal",
        "method",
        "^if",
        "while",
        "for",
        "with",
        "try",
        "except",
        "argument_list",
        "object",
        "dictionary",
        "element",
    },
    context_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
        "IndentBlanklineIndent3",
        "IndentBlanklineIndent4",
        "IndentBlanklineIndent5",
        "IndentBlanklineIndent6",
    },
    space_char_blankline = " ",
    use_treesitter = true,
    show_current_context = true,
    show_trailing_blankline_indent = false,
    show_first_indent_level = false,
    show_foldtext = false,
    strict_tabs = true,
    max_indent_increase = 1,
})
