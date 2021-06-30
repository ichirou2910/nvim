" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

    " Better Comments
    Plug 'tpope/vim-commentary'
    " Change dates fast
    Plug 'tpope/vim-speeddating'
    " Convert binary, hex, etc..
    Plug 'glts/vim-radical'
    " Repeat stuff
    Plug 'tpope/vim-repeat'
    " Text Navigation
    Plug 'unblevable/quick-scope'
    " Useful for React Commenting 
    Plug 'suy/vim-context-commentstring'
    " highlight all matches under cursor
    " Plug 'RRethy/vim-illuminate'
    " Line pulse while moving between search matches
    Plug 'inside/vim-search-pulse'

  if exists('g:vscode')
    " Easy motion for VSCode
    Plug 'asvetliakov/vim-easymotion'
    Plug 'machakann/vim-highlightedyank'
  else

    Plug 'tpope/vim-dispatch'
    " Surround
    Plug 'tpope/vim-surround'
    " Files
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'kyazdani42/nvim-tree.lua'
    Plug 'tpope/vim-eunuch'
    " Have the file system follow you around
    Plug 'airblade/vim-rooter'
    " auto set indent settings
    Plug 'tpope/vim-sleuth'
    Plug 'Yggdroot/indentLine'
    " Plug 'nathanaelkane/vim-indent-guides'
    " Treesitter 
    Plug 'nvim-treesitter/nvim-treesitter'
    Plug 'nvim-treesitter/playground'
    Plug 'p00f/nvim-ts-rainbow'
    " Status Line
    " Plug 'glepnir/galaxyline.nvim', {'branch': 'main'}
    " Cool Icons
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'ryanoasis/vim-devicons'
    " Auto pairs for '(' '[' '{'
    Plug 'jiangmiao/auto-pairs'
    " Closetags
    Plug 'alvan/vim-closetag'
    " Themes
    " Plug 'christianchiarulli/nvcode-color-schemes.vim'
    " Better Syntax Support
    Plug 'jackguo380/vim-lsp-cxx-highlight'
    Plug 'pboettch/vim-cmake-syntax'
    Plug 'tpope/vim-haml'
    Plug 'dart-lang/dart-vim-plugin'
    " Plug 'sheerun/vim-polyglot'
    " Intellisense
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'OmniSharp/omnisharp-vim'
    " Cmake
    " Plug 'vhdirk/vim-cmake'
    Plug 'ilyachur/cmake4vim'
    " Rest API
    Plug 'diepm/vim-rest-console'
    " Plug 'ap/vim-buftabline'
    " Plug 'ichirou2910/vim-buftabline'
    Plug 'kevinhwang91/rnvimr'
    " Buffer management
    Plug 'zefei/vim-wintabs'
    Plug 'zefei/vim-wintabs-powerline'
    " FZF
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    " Git
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rhubarb'
    Plug 'junegunn/gv.vim'
    Plug 'rhysd/git-messenger.vim'
    " Terminal
    Plug 'voldikss/vim-floaterm'
    " Vista
    Plug 'liuchengxu/vista.vim'
    " See what keys do like in emacs
    Plug 'liuchengxu/vim-which-key'
    " Zen mode
    Plug 'junegunn/goyo.vim'
    " Snippets
    Plug 'honza/vim-snippets'
    Plug 'mattn/emmet-vim'
    " Interactive code
    Plug 'metakirby5/codi.vim'
    " Debugging
    Plug 'puremourning/vimspector'
    " undo time travel
    Plug 'mbbill/undotree'
    " Find and replace
    Plug 'ChristianChiarulli/far.vim'
    " Plug 'brooth/far.vim'
    " Auto change html tags
    Plug 'AndrewRadev/tagalong.vim'
    " live server
    Plug 'turbio/bracey.vim'
    " Smooth scroll
    Plug 'psliwka/vim-smoothie'
    " async tasks
    Plug 'skywind3000/asynctasks.vim'
    Plug 'skywind3000/asyncrun.vim'
    " Swap windows
    Plug 'wesQ3/vim-windowswap'
    " Markdown Preview
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & npm install'  }
    " Easily Create Gists
    Plug 'mattn/vim-gist'
    Plug 'mattn/webapi-vim'
    " Colorizer
    Plug 'norcalli/nvim-colorizer.lua'
    Plug 'siduck76/nvim-base16.lua'
    " Rainbow brackets
    " Plug 'luochen1990/rainbow'
    " Plug 'junegunn/rainbow_parentheses.vim'
    " Better Whitespace
    Plug 'ntpeters/vim-better-whitespace'
    " Buffer delete
    Plug 'moll/vim-bbye'
    " Seamless navigation with tmux
    Plug 'christoomey/vim-tmux-navigator'
    " Tmux interaction from vim
    Plug 'preservim/vimux'
    " Sessions
    Plug 'tpope/vim-obsession'
  endif

call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif
