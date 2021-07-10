let g:completion_enable_snippet = 'UltiSnips'

let g:completion_confirm_key = "\<Tab>"
imap <expr> <Tab>
      \ pumvisible() ? complete_info()["selected"] != "-1" ?
			\ <Plug>(completion_confirm_completion) : "\<C-e>\<CR>" : "\<Tab>"
