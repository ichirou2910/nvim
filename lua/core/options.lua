local g = vim.g

-- GENERAL SETTINGS
vim.opt.iskeyword:append("-") -- treat dash separated words as a word text object"
vim.opt.sessionoptions:append("globals")

vim.opt.hidden = true -- Required to keep multiple buffers open multiple buffers
vim.opt.wrap = false -- Display long lines as just one line
vim.opt.whichwrap:append("<>[]hl")
vim.opt.encoding = "utf-8" -- The encoding displayed
vim.opt.pumheight = 10 -- Makes popup menu smaller
vim.opt.fileencoding = "utf-8" -- The encoding written to file
vim.opt.ruler = true -- Show the cursor position all the time
vim.opt.cmdheight = 1 -- More space for displaying messages
vim.opt.equalalways = false -- Prevent auto balance split size when split
vim.opt.mouse = "a" -- Enable your mouse
vim.opt.splitbelow = true -- Horizontal splits will automatically be below
vim.opt.splitright = true -- Vertical splits will automatically be to the right
vim.opt.conceallevel = 0 -- So that I can see `` in markdown files
vim.opt.tabstop = 2 -- Insert 2 spaces for a tab
vim.opt.shiftwidth = 2 -- Change the number of space characters inserted for indentation
vim.opt.smarttab = true -- Makes tabbing smarter will realize you have 2 vs 4
vim.opt.ignorecase = true -- Ignore case, must use for smartcase to work
vim.opt.smartcase = true -- Smart case-insensitve/-sensitive search detection
vim.opt.expandtab = true -- Converts tabs to spaces
vim.opt.smartindent = true -- Makes indenting smart
vim.opt.autoindent = true -- Good auto indent
vim.opt.laststatus = 2 -- Always display the status line
vim.opt.rnu = true -- Relative linenumber
vim.opt.number = true -- Line numbers
vim.opt.cursorline = true -- Enable highlighting of the current line
vim.opt.background = "dark" -- tell vim what the background color looks like
vim.opt.showmode = false -- We don't need to see things like -- INSERT -- anymore
vim.opt.backup = false -- This is recommended by coc
vim.opt.writebackup = false -- This is recommended by coc
vim.opt.shortmess:append("csI") -- Don't pass messages to |ins-completion-menu|.
vim.opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
vim.opt.updatetime = 300 -- Faster completion
vim.opt.clipboard = { "unnamedplus" } -- Copy paste between vim and everything else
vim.opt.incsearch = true
vim.opt.switchbuf = { "useopen", "usetab" }
vim.opt.completeopt = { "menuone", "noselect" }
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99
vim.opt.wrap = false

vim.opt.title = true
vim.opt.cul = true -- cursor line

vim.opt.timeoutlen = 500

-- default notification provider
vim.notify = require("notify")

-- disable tilde on end of buffer: https://github.com/neovim/neovim/pull/8546#issuecomment-643643758
vim.opt.fillchars = { eob = " " }

-- disable some builtin vim plugins
local disabled_built_ins = {
    "2html_plugin",
    "getscript",
    "getscriptPlugin",
    "gzip",
    "logipat",
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "matchit",
    "tar",
    "tarPlugin",
    "rrhelper",
    "spellfile_plugin",
    "vimball",
    "vimballPlugin",
    "zip",
    "zipPlugin",
}

for _, plugin in pairs(disabled_built_ins) do
    g["loaded_" .. plugin] = 1
end

local noAutoComment = vim.api.nvim_create_augroup("NoAutoComment", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    group = noAutoComment,
    command = "setlocal formatoptions-=cro",
    pattern = "*",
})

-- Ibus settings
vim.cmd([[
    " Ibus settings
    function! IBusOff()
        " Save current engine
        let g:ibus_prev_engine = system('ibus engine')
        " Change to English engine
        execute 'silent !ibus engine xkb:us::eng'
    endfunction
    function! IBusOn()
        let l:current_engine = system('ibus engine')
        " If engine was changed in Normal mode, use it instead
        if l:current_engine !~? 'xkb:us::eng'
          let g:ibus_prev_engine = l:current_engine
        endif
        " Restore engine
        execute 'silent !' . 'ibus engine ' . g:ibus_prev_engine
    endfunction

    augroup IBusHandler
        autocmd CmdLineEnter [/?] call IBusOn()
        autocmd CmdLineLeave [/?] call IBusOff()
        autocmd InsertEnter * call IBusOn()
        autocmd InsertLeave * call IBusOff()
    augroup END
    call IBusOff()
]])

-- Hide cursorline on inactive split
local bgHighlight = vim.api.nvim_create_augroup("BgHighlight", { clear = true })
vim.api.nvim_create_autocmd("WinEnter", {
    group = bgHighlight,
    command = "set cul",
    pattern = "*",
})
vim.api.nvim_create_autocmd("WinLeave", {
    group = bgHighlight,
    command = "set nocul",
    pattern = "*",
})

-- Quickfix
local quickfixForceBottom = vim.api.nvim_create_augroup("QuickfixForceBottom", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    group = quickfixForceBottom,
    command = "wincmd J",
    pattern = "qf",
})

-- Highlight yank
local highlightYank = vim.api.nvim_create_augroup("HighlightYank", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    group = highlightYank,
    command = "silent! lua vim.highlight.on_yank{higroup='IncSearch', timeout=700}",
    pattern = "*",
})

-- Project notes
local projectNotes = vim.api.nvim_create_augroup("ProjectNotes", { clear = true })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    group = projectNotes,
    command = "set filetype=notes | set syntax=markdown",
    pattern = "*.notes",
})
