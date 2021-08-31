" Basic Settings
set noerrorbells
set smartindent
set tabstop=8
set shiftwidth=8
set softtabstop=8
set smarttab
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set hlsearch
set encoding=utf-8
set spell spelllang=en_gb
set spell spelllang=en_us

" Show a margin line at column 110 
set colorcolumn=110
highlight ColorColumn ctermbg=0 guibg=lightgrey

" Plugins
call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'tpope/vim-fugitive'
Plug 'vim-utils/vim-man'
Plug 'mbbill/undotree'
Plug 'Valloric/YouCompleteMe'
Plug 'python-mode/python-mode', {'for': 'python', 'branch': 'develop'}
Plug 'lervag/vimtex'

call plug#end()

colorscheme gruvbox
set background=dark

if executable('rg')
    let g:rg_derive_root='true'
endif

let mapleader = " " 
let g:netrw_browse_split=2
let g:netrw_banner = 0
let g:netrw_winsize = 25

let g:ctrlp_use_caching = 0

nnoremap <Leader>h :wincmd h<CR>
nnoremap <Leader>j :wincmd j<CR>
nnoremap <Leader>k :wincmd k<CR>
nnoremap <Leader>l :wincmd l<CR>
nnoremap <Leader>u :UndotreeShow<CR>
nnoremap <Leader>pv :wincmd v<bar> :EX <bar> :vertical resize 30<CR>
nnoremap <Leader>ps :Rg<SPACE>
nnoremap <silent> <Leader>+ :vertical resize +5<CR>
nnoremap <silent> <Leader>- :vertical resize -5<CR>

nnoremap <silent> <Leader>gd :YcmCompleter GoTO<CR>
nnoremap <silent> <Leader>gf :YcmCompleter FixIt<CR>

let g:livepreview_previewer = 'okular'
autocmd Filetype tex setl updatetime=60000

set spell
set spellfile=~/.vim/spell/en.utf-8.add

autocmd Filetype python setlocal expandtab | setlocal tabstop=4 | setlocal shiftwidth=4 |
			\ setlocal softtabstop=4 | setlocal colorcolumn=80
