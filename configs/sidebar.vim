" === Sidebar functions ===

function! s:sidebar_close_api()
  for l:bufnr in range(1, bufnr("$"))
    if bufname(l:bufnr) =~ "api.http"
      lua vim.api.nvim_buf_delete(vim.api.nvim_eval("l:bufnr"), {})
    endif
  endfor
endfunction

function! s:sidebar_close_git()
  for l:bufnr in range(1, bufnr("$"))
    if bufname(l:bufnr) =~? "^fugitive:///"
      lua vim.api.nvim_buf_delete(vim.api.nvim_eval("l:bufnr"), {})
    endif
  endfor
endfunction

function! s:sidebar_close_notes()
  for l:bufnr in range(1, bufnr("$"))
    if bufname(l:bufnr) =~ "project-notes.notes"
      lua vim.api.nvim_buf_delete(vim.api.nvim_eval("l:bufnr"), {})
    endif
  endfor
endfunction

command! SidebarCloseApi call s:sidebar_close_api()
command! SidebarCloseGit call s:sidebar_close_git()
command! SidebarCloseNotes call s:sidebar_close_notes()

" === Sidebar config ===

let g:sidebar_width = 55

let g:sidebars = {
  \ "api": {
  \     "position": "right",
  \     "check_win": {nr -> bufname(winbufnr(nr)) =~ "api.http"},
  \     "open": "vnew api.http" .. " | set winfixwidth",
  \     "close": "SidebarCloseApi"
  \ },
  \ "database": {
  \     "position": "left",
  \     "check_win": {nr -> bufname(winbufnr(nr)) =~ "dbui"},
  \     "open": "DBUIToggle",
  \     "close": "DBUIToggle"
  \ },
  \ "debug": {
  \     "position": "left",
  \     "check_win": {nr -> bufname(winbufnr(nr)) =~ "DAP Scopes"},
  \     "open": "lua require'dapui'.toggle()",
  \     "close": "lua require'dapui'.toggle()",
  \ },
  \ "files": {
  \     "position": "left",
  \     "check_win": {nr -> bufname(winbufnr(nr)) =~ "NvimTree"},
  \     "open": "NvimTreeOpen",
  \     "close": "NvimTreeClose"
  \ },
  \ "git": {
  \     "position": "left",
  \     "check_win": {nr -> bufname(winbufnr(nr)) =~? "^fugitive:///"},
  \     "open": "topleft vert Git | vertical resize " .. g:sidebar_width .. " | setlocal winfixwidth nobuflisted",
  \     "close": "SidebarCloseGit"
  \ },
  \ "notes": {
  \     "position": "left",
  \     "check_win": {nr -> bufname(winbufnr(nr)) =~ "project-notes.notes"},
  \     "open": "topleft " .. g:sidebar_width .. " vnew project-notes.notes" .. " | setlocal cursorline noswapfile winfixwidth nobuflisted bufhidden=hide",
  \     "close": "SidebarCloseNotes"
  \ },
  \ }

noremap <silent> <leader>sc :call sidebar#close_all()<CR>

noremap <silent> <leader>sa :call sidebar#toggle("api")<CR>
noremap <silent> <leader>sb :call sidebar#toggle("debug")<CR>
noremap <silent> <leader>sd :call sidebar#toggle("database")<CR>
noremap <silent> <leader>se :call sidebar#toggle("files")<CR>
noremap <silent> <leader>sg :call sidebar#toggle("git")<CR>
noremap <silent> <leader>sn :call sidebar#toggle("notes")<CR>
