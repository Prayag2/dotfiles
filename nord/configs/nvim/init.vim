" General Settings
set nocompatible
set showmatch
set tabstop=4
set autoindent
set number
set nocompatible
set clipboard+=unnamedplus

" Syntax Highlighting
syntax on

" Autocomplete brackets and commas
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>

" Plugins
call plug#begin("~/.nvim/plugged")
Plug 'sheerun/vim-polyglot' 
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase'}
Plug 'shaunsingh/nord.nvim'
call plug#end()

" Highlighting color codes
let g:Hexokinase_highlighters = [ 'virtual' ]

source $HOME/.config/nvim/coc.vim

" Theme
colorscheme nord
