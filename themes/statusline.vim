set showtabline=2                       " Always show tabs

" Initialize
set statusline=

let g:statusline_override_filtypes = {
			\ 'coc-explorer': 'CoC Explorer',
			\ 'vista': 'Vista',
			\}


function! StatusLineGit()
	if isdirectory('.git')
		let [a,m,r] = GitGutterGetHunkSummary()
		let head = FugitiveHead()
		return printf('(%s) +%d ~%d -%d', head, a, m, r)
	else
		return ''
	endif
endfunction

function! StatusLineFilePath()
	let l:type= &filetype
	if has_key(g:statusline_override_filtypes, l:type)
		return ''
	else
		return fnamemodify(expand('%'), ":~:.")
	endif
endfunction

function! StatusLineFileType()
	let l:type= &filetype
	if has_key(g:statusline_override_filtypes, l:type)
		return ''
	else
		return '[' . l:type . ']'
	endif
endfunction

function! StatusLineFileFormat()
	let l:type= &filetype
	let l:format= &fileformat
	if has_key(g:statusline_override_filtypes, l:type)
		return ''
	else
		return l:format
	endif
endfunction

function! StatusLineCurLine()
	let l:type= &filetype
	let l:linenr= line('.')
	if has_key(g:statusline_override_filtypes, l:type)
		return ''
	else
		return ' '. l:linenr
	endif
endfunction

function! StatusLineMaxLine()
	let l:type= &filetype
	let l:maxlinenr= line('$')
	if has_key(g:statusline_override_filtypes, l:type)
		return ''
	else
		return '/'.l:maxlinenr.' '
	endif
endfunction

function! StatusLineCurCol()
	let l:type= &filetype
	let l:colnr= col('.')
	if has_key(g:statusline_override_filtypes, l:type)
		return ''
	else
		return colnr
	endif
endfunction

function! StatusLineCoc()
	let l:type = &filetype
	if has_key(g:statusline_override_filtypes, l:type)
		return g:statusline_override_filtypes[l:type]
	else
		return ''
	endif
endfunction

function! StatusLinePart(part)
	let l:type = &filetype
	if has_key(g:statusline_override_filtypes, l:type)
		return ''
	else
		return a:part
	endif
endfunction

" Colorized NV
set statusline+=%4*\ %{StatusLineCoc()}%*
set statusline+=%3*%{StatusLinePart('\[N')}%*
set statusline+=%6*%{StatusLinePart('V\]')}%*

" Git status
set statusline+=%7*\ %{StatusLinePart(StatusLineGit())}\ %*

" CoC status
set statusline+=%5*%{StatusLinePart(get(b:,'coc_current_function',''))}%*

" File path
set statusline+=%1*%{StatusLineFilePath()}\ %*             

" Session status
set statusline+=%7*%=%{StatusLinePart(ObsessionStatus())}\ %*

" File type
set statusline+=%3*%{StatusLineFileType()}\ %*             

" File format
set statusline+=%4*%{StatusLineFileFormat()}\ %*       

" Current line
set statusline+=%6*%5{StatusLineCurLine()}%*             	

" Max line
set statusline+=%2*%{StatusLineMaxLine()}%*              

" Current column
set statusline+=%6*%4{StatusLineCurCol()}\ %*

hi User1 guifg=#e67e22 guibg=#282c34
hi User2 guifg=#fc514e guibg=#282c34
hi User3 guifg=#57c7ff guibg=#282c34
hi User4 guifg=#eeee40 guibg=#282c34
hi User5 guifg=#ffffff guibg=#282c34
hi User6 guifg=#a0ee40 guibg=#282c34
hi User7 guifg=#ae81ff guibg=#282c34
