" General Settings
set nocompatible
set showmatch
set tabstop=4
set autoindent
set number
set nocompatible
set clipboard+=unnamedplus
filetype plugin on

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
"Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase'}
Plug 'vimwiki/vimwiki'
call plug#end()

" Highlighting color codes
"let g:Hexokinase_highlighters = [ 'virtual' ]

source $HOME/.config/nvim/coc.vim

" Theme
" colorscheme gruvbox

" VimWiki settings
let g:vimwiki_list = [{'path': '~/Documents/Notes/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]

inoremap <silent><expr> <c-space> coc#refresh()
