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

" frequently used
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'NLKNguyen/papercolor-theme'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'benmills/vimux'
"Plugin 'suan/vim-instant-markdown'
Plugin 'kshenoy/vim-signature'
Plugin 'tpope/vim-surround'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'scrooloose/nerdcommenter'
" evaluating
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
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

map <C-n> :NERDTreeToggle<CR>

"Disable arrow keys on normal mode 
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

"Make Ctrl+Shift+Arrow not delete text
if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif

"Use system clipboard for copy/paste
vmap "+y :!xclip -f -sel clip
map "+p :r!xclip -o -sel clip

"sane copy paste
vnoremap <C-c> "*y


set encoding=utf8
set nu
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set cindent
set copyindent
set preserveindent
set esckeys
set ignorecase
set foldmethod=manual
set clipboard+=unnamedplus
set t_Co=256
if exists('$TMUX')
    set term=screen-256color
endif
set timeout timeoutlen=500

"highlight current
set cursorline
set cursorcolumn
let &colorcolumn=join(range(101,255),',')

" statusline
set laststatus=2
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"conditional relative line numbers
set rnu
:au FocusLost * :set number
:au FocusGained * :set relativenumber

" remap move lines up / down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

"consistent visual indent
vnoremap < <gv
vnoremap > >gv

"General settings
let mapleader=","
let NERDTreeShowHidden=1

"Theme
let g:airline_powerline_fonts=1
let g:airline_theme='powerlineish'
set background=dark
syntax on
colorscheme PaperColor 

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_symbols.space = "\ua0"
set guifont=Inconsolata-dz\ for\ Powerline\ Medium\ 12
"Syntax checkers
let g:JSHintHighlightErrorLine=0
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0
let g:syntastic_javascript_checkers = ['eslint']

