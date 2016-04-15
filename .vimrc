set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.fzf
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-fugitive'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'wookiehangover/jshint.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'scrooloose/nerdcommenter'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'scrooloose/syntastic'
Plugin 'vim-scripts/taglist.vim'
Plugin 'shougo/neosnippet.vim'
Plugin 'benmills/vimux'
Plugin 'nanotech/jellybeans.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'Shougo/deoplete.nvim'
Plugin 'suan/vim-instant-markdown'
Plugin 'wincent/command-t'
Plugin 'kshenoy/vim-signature'
Plugin 'tpope/vim-surround'
Plugin 'christoomey/vim-tmux-navigator'
"All of your Plugins must be added before the following line

call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
filetype plugin on

" format JSON
map json :%!python -m json.tool
map <C-n> :NERDTreeToggle<CR>
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
vmap "+y :!xclip -f -sel clip
map "+p :r!xclip -o -sel clip

set encoding=utf8
set nu
set tabstop=4
set shiftwidth=4
set expandtab
set ignorecase
set clipboard+=unnamedplus
set laststatus=2
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let mapleader=","
let NERDTreeShowHidden=1
let g:airline_powerline_fonts=1
let g:airline_theme='powerlineish'
let g:JSHintHighlightErrorLine=0
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0
autocmd FileType javascript let b:syntastic_checkers = findfile('.jscsrc', '.;') != '' ? ['jscs'] : ['jshint']
syntax on
set background=dark
colorscheme solarized
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
  let g:airline_symbols.space = "\ua0"
set guifont=Inconsolata-dz\ for\ Powerline\ Medium\ 12
