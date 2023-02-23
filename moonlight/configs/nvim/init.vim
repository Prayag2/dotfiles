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
Plug 'norcalli/nvim-colorizer.lua'
Plug 'vimwiki/vimwiki'
Plug 'dylanaraps/wal.vim'
call plug#end()

" Highlighting color codes
" let g:Hexokinase_highlighters = [ 'virtual' ]

source $HOME/.config/nvim/coc.vim

" Theme
colorscheme wal

" VimWiki settings
let g:vimwiki_list = [{
                  \ 'path': '$HOME/Documents/Notes/vimwiki/', 
                  \ 'syntax': 'markdown', 
                  \ 'ext': '.md', 
                  \ 'custom_wiki2html': 'vimwiki_markdown', 
                  \ 'path_html': '$HOME/Documents/vimwiki/', 
                  \ 'template_path': '$HOME/.config/nvim/', 
                  \ 'template_default': 'template', 
                  \ 'template_ext': '.html'}]

inoremap <silent><expr> <c-space> coc#refresh()
