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
    " Repeat stuff
    Plug 'tpope/vim-repeat'
    " Text Navigation
    Plug 'unblevable/quick-scope'
    " Line pulse while moving between search matches
    Plug 'inside/vim-search-pulse'
    " Startup time
    Plug 'tweekmonster/startuptime.vim'

  if exists('g:vscode')
    " Easy motion for VSCode
    Plug 'asvetliakov/vim-easymotion'
    Plug 'machakann/vim-highlightedyank'
  else

    " Async dispatch
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
    " Treesitter 
    Plug 'nvim-treesitter/nvim-treesitter'
    Plug 'nvim-treesitter/playground'
    " Cool Icons
    Plug 'kyazdani42/nvim-web-devicons'
    " Auto pairs for '(' '[' '{'
    Plug 'jiangmiao/auto-pairs'
    " Better Syntax Support
    Plug 'pboettch/vim-cmake-syntax'
    " Plug 'tpope/vim-haml'
    Plug 'dart-lang/dart-vim-plugin'
    " Cmake
    Plug 'ilyachur/cmake4vim'
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
    " WhichKey
    Plug 'folke/which-key.nvim'
    " Snippets
    Plug 'mattn/emmet-vim'
    " Interactive code
    Plug 'metakirby5/codi.vim'
    " Debugging
    Plug 'puremourning/vimspector'
    " undo time travel
    Plug 'mbbill/undotree'
    " Find and replace
    Plug 'ChristianChiarulli/far.vim'
    " Auto change html tags
    Plug 'AndrewRadev/tagalong.vim'
    " Smooth scroll
    Plug 'psliwka/vim-smoothie'
    " Markdown Preview
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & npm install'  }
    " Colorizer
    Plug 'norcalli/nvim-colorizer.lua'
    Plug 'siduck76/nvim-base16.lua'
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
    " Nvim LSP
    Plug 'neovim/nvim-lspconfig'
    Plug 'kabouzeid/nvim-lspinstall'
    Plug 'onsails/lspkind-nvim'
    Plug 'glepnir/lspsaga.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    " Auto complete
    Plug 'nvim-lua/completion-nvim'
    " Snippets
    Plug 'hrsh7th/vim-vsnip'
    Plug 'hrsh7th/vim-vsnip-integ'
    " Format
    Plug 'sbdchd/neoformat'
  endif

call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif
