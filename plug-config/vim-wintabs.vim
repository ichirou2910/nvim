let g:wintabs_display ="statusline"

let g:wintabs_ui_buffer_name_format = ' %o %t '

nmap <A-1> :WintabsGo 1<CR>
nmap <A-2> :WintabsGo 2<CR>
nmap <A-3> :WintabsGo 3<CR>
nmap <A-4> :WintabsGo 4<CR>
nmap <A-5> :WintabsGo 5<CR>
nmap <A-6> :WintabsGo 6<CR>
nmap <A-7> :WintabsGo 7<CR>
nmap <A-8> :WintabsGo 8<CR>
nmap <A-9> :WintabsGo -1<CR>

let g:wintabs_powerline_arrow_left = ""
let g:wintabs_powerline_arrow_right = ""
let g:wintabs_powerline_sep_buffer_transition= ""
let g:wintabs_powerline_sep_buffer = ""

hi! WintabsEmpty guifg=NONE guibg=#252931
hi! WintabsActive guifg=#dce0e5 guibg=#1e222a
hi! WintabsInactive guifg=#6f7379 guibg=#252931
hi! link WintabsArrow WintabsInactive
hi! WintabsActiveNC guifg=#6f7379 guibg=#1e222a
hi! WintabsInactiveNC guifg=#4d4d4d guibg=#252931
