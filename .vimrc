
"
" Package management (vim-plug)
"

call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'ap/vim-buftabline'
Plug 'joshdick/onedark.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
"Plug 'jwalton512/vim-blade'
Plug 'kudabux/vim-srcery-drk'
Plug 'matze/vim-move'
Plug 'mhinz/vim-startify'
Plug 'scrooloose/nerdcommenter'
Plug 'sheerun/vim-polyglot'
" Plug 't9md/vim-choosewin'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-eunuch'
" Plug 'tpope/vim-fugitive'
" Plug 'tpope/vim-git'
Plug 'vim-airline/vim-airline'
Plug 'w0rp/ale'
Plug 'Yggdroot/indentLine'
call plug#end()

"
" Basics
"

" Colour scheme
syntax on 
colorscheme srcery-drk
" set background=dark " Comment this out for some schemes

" Editor
set number      " Show line numbers
set ruler       " Show the ruler

" Splits
" Note: Check the leader key shortcuts below for some commands that might
" conflict with these if you need to change these around...
set splitright  " Make vertical splits appear to the right
set splitbelow  " Make horizontal splits appear to the bottom

" Search
set hlsearch    " Highlight searched pattern 
set ignorecase  " Ignore case when pattern searching
set incsearch   " Refine search as each character is typed

" Backspace
set backspace=2 " Make backspace delete past where insert mode began

" Tab completion
set wildmode=longest,list,full
set wildmenu

" Indentation
filetype indent on
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab   " DO NOT Expand tabs into several spaces
set smarttab      " Tab to implied indentation depth automatically (I think?)
set nowrap        " Don't wrap text

" Undo files
"set undofile
"set undodir=~/.vim/undo
set undolevels=100
set directory=~/.vim/swap
set backupdir=~/.vim/backup


"
" Filetype-specific settings
" 

filetype plugin on
autocmd Filetype html set wrap
autocmd Filetype log set wrap

" Blade files set as blade type
autocmd BufRead,BufNewFile *.blade.php set filetype=blade

" use spaces in php
autocmd FileType php setlocal expandtab

" And not use them in blade...
autocmd FileType blade setlocal noexpandtab

"
" Key mapping
"

" Leader key
" let mapleader = "\<space>"

" Omnicomplete
"inoremap <A-Tab> <C-x><C-o> 

" Copypasta
vmap <leader>d :w !pbcopy<cr><cr>gvd
vmap <leader>y :w !pbcopy<cr><cr>

" fzf
nmap <leader>f :FzfLaravel<cr>
nmap <leader>a :Ag!<cr>
nmap <leader>s :Lines!<cr>
nmap <leader>d :BLines<cr>
nmap <leader>b :Buffers<cr>
nmap <leader>m :Marks<cr>
nmap <leader>g :GFiles?<cr>
nmap <leader><cr> :nohl<cr>

" Buffers
nmap <leader>w :w<cr>
nmap <leader>q :bd<cr>
nmap <leader><BS><BS> :bufdo bd<cr>
nmap <leader>1 <Plug>BufTabLine.Go(1)
nmap <leader>2 <Plug>BufTabLine.Go(2)
nmap <leader>3 <Plug>BufTabLine.Go(3)
nmap <leader>4 <Plug>BufTabLine.Go(4)
nmap <leader>5 <Plug>BufTabLine.Go(5)
nmap <leader>6 <Plug>BufTabLine.Go(6)
nmap <leader>7 <Plug>BufTabLine.Go(7)
nmap <leader>8 <Plug>BufTabLine.Go(8)
nmap <leader>9 <Plug>BufTabLine.Go(9)
nmap <leader>0 <Plug>BufTabLine.Go(0)

" Commenting
nmap <leader>/ <Plug>NERDCommenterInvert
vmap <leader>/ <Plug>NERDCommenterInvert
nmap <leader>c <Plug>NERDCommenterInvert
vmap <leader>c <Plug>NERDCommenterInvert

"
" ap/vim-buftabline
"

let g:buftabline_show = 2       " Always show
let g:buftabline_numbers = 2    " Ordinal from left-to-right

"
" junegunn/fzf
"

let g:fzf_layout = {
  \ 'down': '~40%'
  \ }

let g:fzf_colors = {
  \ 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment']
  \ }

"
" scrooloose/nerdcommenter
"

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

"
" tpope/vim-abolish
"

"Abolish parley parlay
iabbrev parley parlay
iabbrev Parley Parlay

"
" vim-airline/vim-airline
"

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'onedark'
let g:airline#extensions#tabline#buffer_nr_show = 1

"
" w0rg/ale
"

" General
let g:ale_completion_enabled = 1
let g:ale_lint_on_text_changed = 1
let g:ale_set_highlights = 1

" phpcs
let g:ale_php_phpcs_executable = './bin/phpcs'
let g:ale_php_phpcs_standard = "psr4"
let g:ale_php_phpmd_ruleset = 'cleancode,codesize,controversial,design,unusedcode'

"
" Yggroot/indentLine
"

"let g:indentLine_setColors = 0
let g:indentLine_color_term = 239
let g:indentLine_char = '│'

"
" netrw
"

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 2
let g:netrw_altv = 0
let g:netrw_winsize = 20

"
" Commands & Functions
"

" Clear every register.
function! ClearRegisters()
    let regs='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-="*+'
    let i=0
    while (i<strlen(regs))
        exec 'let @'.regs[i].'=""'
        let i=i+1
    endwhile
endfunction
command! ClearRegisters call ClearRegisters()

" Use FZF to search a Laravel project
command! FzfLaravel call fzf#run({
    \ 'source': 'find . -type f -not -path "*/.git/*" -not -path "*/node_modules/*" -not -path "*/vendor/*" -not -path "*/storage/framework/*"',
    \ 'sink': 'e',
    \ 'down': '~40%'
    \ })
