let g:completion_enable_snippet = 'vim-vsnip'
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy', 'all']
let g:completion_matching_smart_case = 1
let g:completion_sorting = "length"

let g:completion_confirm_key = ""
imap <expr> <Tab>
      \ pumvisible() ? complete_info()["selected"] != "-1" ?
			\ "\<Plug>(completion_confirm_completion)" : "\<C-e>\<CR>" : "\<Tab>"
