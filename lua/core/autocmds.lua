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

-- C# LSP definition
vim.api.nvim_command([[
  autocmd FileType cs nnoremap <buffer> <leader>ld :lua vim.lsp.buf.definition()<CR>
]])
