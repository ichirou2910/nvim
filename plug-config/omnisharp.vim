" Coc-omnisharp doesn't support this well, so map to the original omnisharp
autocmd FileType cs let g:which_key_map.l['d'] = [':OmniSharpGotoDefinition', 'definition']
