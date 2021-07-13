let g:vimspector_enable_mappings='HUMAN'
source $HOME/.config/nvim/vim-plug/plugins.vim
source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/general/functions.vim

if !exists('g:vscode')
  source $HOME/.config/nvim/general/theme.vim
endif

source $HOME/.config/nvim/keys/mappings.vim
source $HOME/.config/nvim/plug-config/vim-commentary.vim
source $HOME/.config/nvim/plug-config/quickscope.vim

" Filetype-specific mappings
for f in split(glob('$HOME/.config/nvim/keys/filetypes/*.vim'), '\n')
  exe 'source' f
endfor

if exists('g:vscode')
  " VS Code extension
  source $HOME/.config/nvim/vscode/settings.vim
else

  " Themes
  source $HOME/.config/nvim/themes/syntax.vim
  source $HOME/.config/nvim/themes/statusline.vim

  " Plugin Configuration
  source $HOME/.config/nvim/plug-config/emmet.vim
  source $HOME/.config/nvim/plug-config/vim-commentary.vim
  source $HOME/.config/nvim/plug-config/rainbow.vim
  source $HOME/.config/nvim/plug-config/better-whitespace.vim
  source $HOME/.config/nvim/plug-config/indent-line.vim
  source $HOME/.config/nvim/plug-config/fzf.vim
  source $HOME/.config/nvim/plug-config/vim-wiki.vim
  source $HOME/.config/nvim/plug-config/vim-wintabs.vim
  source $HOME/.config/nvim/plug-config/cmake4vim.vim
  source $HOME/.config/nvim/plug-config/vim-rooter.vim
  source $HOME/.config/nvim/plug-config/gitgutter.vim
  source $HOME/.config/nvim/plug-config/git-messenger.vim
  source $HOME/.config/nvim/plug-config/closetags.vim
  source $HOME/.config/nvim/plug-config/floaterm.vim
  source $HOME/.config/nvim/plug-config/vista.vim
  source $HOME/.config/nvim/plug-config/far.vim
  source $HOME/.config/nvim/plug-config/tagalong.vim
  source $HOME/.config/nvim/plug-config/markdown-preview.vim
  source $HOME/.config/nvim/plug-config/vimux.vim
  " source $HOME/.config/nvim/plug-config/completion.vim

  lua require('plugins.lspconfig').config()
  lua require('plugins.which-key').config()
  lua require('plugins.lspsaga')
  lua require('plugins.compe').config()
  luafile $HOME/.config/nvim/lua/plug-colorizer.lua
  luafile $HOME/.config/nvim/lua/plugins/nvimtree.lua
  luafile $HOME/.config/nvim/lua/plugins/treesitter-config.lua
  luafile $HOME/.config/nvim/lua/theme.lua

  source $HOME/.config/nvim/plug-config/vimspector.vim
endif

" Add paths to node and python here
if !empty(glob("~/.config/nvim/paths.vim"))
  source $HOME/.config/nvim/paths.vim
endif

inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")
