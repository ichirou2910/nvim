let g:completion_enable_snippet = 'vim-vsnip'

let g:completion_confirm_key = ""
imap <expr> <Tab>
      \ pumvisible() ? complete_info()["selected"] != "-1" ?
			\ "\<Plug>(completion_confirm_completion)" : "\<C-e>\<CR>" : "\<Tab>"
