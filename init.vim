" General Settings
if !exists('g:vscode')
  source $HOME/.config/nvim/plug-config/polyglot.vim
endif

let g:vimspector_enable_mappings='HUMAN'
source $HOME/.config/nvim/vim-plug/plugins.vim
source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/general/functions.vim
source $HOME/.config/nvim/general/theme.vim
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
  source $HOME/.config/nvim/plug-config/easymotion.vim
  source $HOME/.config/nvim/plug-config/highlightyank.vim
else

  " Themes
  source $HOME/.config/nvim/themes/syntax.vim
  source $HOME/.config/nvim/themes/statusline.vim
  " source $HOME/.config/nvim/themes/tabline.vim

  " Plugin Configuration
  source $HOME/.config/nvim/keys/which-key.vim
  source $HOME/.config/nvim/plug-config/vim-commentary.vim
  source $HOME/.config/nvim/plug-config/rainbow.vim
  source $HOME/.config/nvim/plug-config/rnvimr.vim
  source $HOME/.config/nvim/plug-config/better-whitespace.vim
  source $HOME/.config/nvim/plug-config/indent-line.vim
  source $HOME/.config/nvim/plug-config/fzf.vim
  source $HOME/.config/nvim/plug-config/codi.vim
  source $HOME/.config/nvim/plug-config/vim-wiki.vim
  source $HOME/.config/nvim/plug-config/coc.vim
  source $HOME/.config/nvim/plug-config/omnisharp.vim
  source $HOME/.config/nvim/plug-config/vim-wintabs.vim
  " source $HOME/.config/nvim/plug-config/buftabline.vim
  source $HOME/.config/nvim/plug-config/cmake4vim.vim
  source $HOME/.config/nvim/plug-config/nvimtree-config.vim
  source $HOME/.config/nvim/plug-config/rest-console.vim
  source $HOME/.config/nvim/plug-config/goyo.vim
  source $HOME/.config/nvim/plug-config/vim-rooter.vim
  source $HOME/.config/nvim/plug-config/gitgutter.vim
  source $HOME/.config/nvim/plug-config/git-messenger.vim
  source $HOME/.config/nvim/plug-config/closetags.vim
  source $HOME/.config/nvim/plug-config/floaterm.vim
  source $HOME/.config/nvim/plug-config/vista.vim
  source $HOME/.config/nvim/plug-config/xtabline.vim
  source $HOME/.config/nvim/plug-config/far.vim
  source $HOME/.config/nvim/plug-config/tagalong.vim
  " source $HOME/.config/nvim/plug-config/illuminate.vim
  source $HOME/.config/nvim/plug-config/asynctask.vim
  source $HOME/.config/nvim/plug-config/window-swap.vim
  source $HOME/.config/nvim/plug-config/markdown-preview.vim
  " luafile $HOME/.config/nvim/lua/plugins/galaxyline-config.lua
  luafile $HOME/.config/nvim/lua/plug-colorizer.lua
  luafile $HOME/.config/nvim/lua/plugins/nvimtree-config.lua
  luafile $HOME/.config/nvim/lua/plugins/treesitter-config.lua
  source $HOME/.config/nvim/plug-config/vimspector.vim " Uncomment if you want to use Vimspector
endif

" Add paths to node and python here
if !empty(glob("~/.config/nvim/paths.vim"))
  source $HOME/.config/nvim/paths.vim
endif

" Better nav for omnicomplete TODO figure out why this is being overridden
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")
