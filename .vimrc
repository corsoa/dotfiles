set nocompatible              " be iMproved, required
filetype off                  " required

call plug#begin()
" frequently used
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'christoomey/vim-tmux-navigator'
Plug 'benmills/vimux'
Plug 'kshenoy/vim-signature'
Plug 'tpope/vim-surround'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'scrooloose/nerdcommenter'
" evaluating
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'morhetz/gruvbox'
Plug 'leafgarland/typescript-vim'
Plug 'pangloss/vim-javascript'
call plug#end()

filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
filetype plugin on
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

cmap w!! w !sudo tee > /dev/null %

set encoding=utf8
set nu
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
set smartindent
set cindent
set copyindent
set preserveindent
" set esckeys
set ignorecase
set foldmethod=manual
set clipboard+=unnamedplus
set t_Co=256
if exists('$TMUX') && has('vim')
  set term=screen-256color
endif
set timeout timeoutlen=500

"highlight current
set cursorline
"let &colorcolumn=join(range(101,255),',')

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
colorscheme gruvbox

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
"Syntax Highlight
let g:javascript_plugin_jsdoc=1
"Syntax checkers
let g:JSHintHighlightErrorLine=0
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_typescript_checkers = ['tslint', 'tsc']
let g:syntatic_javascript_eslint_exe = 'npm run eslint --'

let g:syntastic_quiet_messages = {
    \ "!level":  "errors",
    \ "type":    "style",
    \ "regex":   '\m\[C03\d\d\]',
    \ "file:p":  ['\m^/usr/include/', '\m\c\.h$'] }
