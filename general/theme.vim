let g:nvcode_termcolors=256

syntax on

if (has('termguicolors'))
	" let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	" let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	set termguicolors

	hi LineNr ctermbg=NONE guibg=NONE
	hi Normal ctermbg=None guibg=None
	" hi! NonText ctermbg=None guibg=None
	" hi! VertSplit guibg=NONE guifg=#303030
	hi! VertSplit guibg=NONE guifg=#121212
	hi! StatusLine gui=bold guibg=#0e0e0e
	hi! StatusLineNC guibg=#0e0e0e
	hi! Todo gui=bold guibg=#282c34
	" hi! Comment cterm=italic 
	" hi! CursorLineNr ctermbg=236 ctermfg=NONE guibg=#303030
	hi! CursorLine ctermbg=236 ctermfg=NONE guibg=#212529
	hi! NormalFloat ctermbg=236 ctermfg=NONE guibg=#212529
	hi! SignColumn ctermbg=NONE guibg=NONE
	hi! MatchParen guibg=NONE guifg=#1167b1 gui=bold
	" hi! Folded ctermbg=NONE guibg=NONE
	" hi! EndOfBuffer ctermbg=NONE ctermfg=NONE guibg=NONE guifg=#080808
	" hi! WildMenu ctermfg=226 ctermbg=0 guifg=#ffff00 guibg=#000000
	" hi! GitGutterChangeDelete ctermbg=NONE guibg=NONE
endif
