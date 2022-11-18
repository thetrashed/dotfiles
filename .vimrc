" Basic Settings
set noerrorbells
set smartindent
set tabstop=2
set shiftwidth=2
set softtabstop=2
set smarttab
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

" Searching
set incsearch
set hlsearch
nnoremap <silent> <C-h> :noh<CR>

" Encoding and spell checking
set encoding=utf-8
set spell
set spell spelllang=en_gb
set spellfile=~/.vim/spell/en.utf-8.add

" Current Line Number Highlighting 
set cursorline
highlight clear CursorLine
highlight CursorLineNR ctermbg=white

" Show a margin line at column 80
set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=#2E3440

" Plugins
call plug#begin('~/.vim/plugged')

	" Plug 'morhetz/gruvbox'
	" Plug 'arcticicestudio/nord-vim'
	Plug 'jaredgorski/spacecamp'
	Plug 'tpope/vim-fugitive'
	Plug 'vim-utils/vim-man'
	Plug 'mbbill/undotree'
	Plug 'Valloric/YouCompleteMe'
	Plug 'preservim/nerdtree', { 'on' : 'NERDTreeToggle' }
	Plug 'python-mode/python-mode', {'for': 'python', 'branch': 'develop'}
	Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
	Plug 'JuliaEditorSupport/julia-vim', { 'for': 'julia' }
	Plug 'rust-lang/rust.vim', { 'for': 'rust' }
	Plug 'zah/nim.vim', { 'for': 'nim' }
	Plug 'luochen1990/rainbow'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'

call plug#end()


" Rainbow
let g:rainbow_active = 1
let g:rainbow_conf = {
\	'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
\	'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
\	'guis': [''],
\	'cterms': [''],
\	'operators': '_,_',
\	'parentheses': [
\			'start=/(/ end=/)/ fold', 
\			'start=/\[/ end=/\]/ fold', 
\			'start=/{/ end=/}/ fold'
\	]
\}


" Theme

" let g:gruvbox_guisp_fallback="bg"
" let g:gruvbox_italic=1
set background=dark
colorscheme spacecamp
highlight Comment ctermfg=darkgray cterm=italic

let mapleader = " " 
let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 25


" Moving between splits
nnoremap <Leader>h :wincmd h<CR>
nnoremap <Leader>j :wincmd j<CR>
nnoremap <Leader>k :wincmd k<CR>
nnoremap <Leader>l :wincmd l<CR>

" Horizontal split
nnoremap <Leader>ph :wincmd s<CR> 
nnoremap <silent> <Leader>] :horizontal resize +5<CR>
nnoremap <silent> <Leader>[ :horizontal resize -5<CR>

" Vertical split
nn <Leader>pp :wincmd v <CR>
nnoremap <silent> <Leader>= :vertical resize +5<CR>
nnoremap <silent> <Leader>- :vertical resize -5<CR>

" NERDTree
nnoremap <Leader>f :NERDTree<CR>

" YCM (Dependent on file support by YCM)
nnoremap <silent> gd :YcmCompleter GoTo<CR>
nnoremap <silent> gh :YcmCompleter GetHover<CR>
nnoremap <silent> gf :YcmCompleter GetDoc<CR>

" Undo Tree
nnoremap <Leader>u :UndotreeShow<CR>

" Terminal
nnoremap <Leader>tl :vert term<CR>
nnoremap <Leader>tj :bel term<CR>
nnoremap <Leader>tk :above term<CR>

" Tex Files
augroup filetype_tex
	autocmd!
	autocmd BufNewFile,BufRead *.tex set syntax=tex
	autocmd BufNewFile,BufRead *.cls set syntax=tex
augroup END

let g:livepreview_previewer = 'okular'
let g:livepreview_engine = 'pdflatex'
let g:livepreview_cursorhold_recompile = 0
autocmd Filetype tex setl updatetime=1000
nnoremap <Leader>re :LLPStartPreview<CR>


" HTML files
augroup filetype_html
	autocmd Filetype html,xhtml setl ofu=htmlcomplete#CompleteTags
augroup end


" Python
autocmd Filetype python setlocal expandtab | setlocal tabstop=4 | 
			\setlocal shiftwidth=4 | setlocal softtabstop=4


" Rust
autocmd Filetype rust setlocal expandtab | setlocal tabstop=4 |
			\setlocal shiftwidth=4 | setlocal softtabstop=4
let g:rustfmt_autosave = 1


" Nim
let g:ycm_language_server = [
\   {
\     'name': 'nim',
\     'cmdline': [ 'nimlsp' ],
\     'filetypes': [ 'nim' ],
\   },
\ ]

" Statusbar - Airline
function! AirlineInit()
	let g:airline_section_warning = ""
	let g:airline_section_z = airline#section#create([g:airline_symbols.linenr."%4p%%".g:airline_symbols.space.g:airline_symbols.space.g:airline_symbols.colnr."%3c"])
endfunction

autocmd User AirlineAfterInit call AirlineInit()
let g:airline_powerline_fonts = 1
let g:airline_theme = "minimalist"
let g:airline_skip_empty_sections = 1
