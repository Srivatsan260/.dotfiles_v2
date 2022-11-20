" vim:fileencoding=utf-8:foldmethod=marker

" editor {{{

set noerrorbells
set nu
set relativenumber

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set wrap

set nohlsearch
set incsearch

set scrolloff=8
set signcolumn=yes
set colorcolumn=100

set noswapfile
set nobackup

set termguicolors
set updatetime=200
set cmdheight=1
set nosplitright

set grepprg="rg --vimgrep --no-heading --smart-case"
set grepformat="%f:%l:%c:%m"

set laststatus=2
set background="dark"
set showmatch

set list
set listchars=tab:»\ ,eol:↲,nbsp:␣,trail:•
set showbreak='↪'

set backspace=indent,eol,start
set clipboard=unnamed

let mapleader=" "
let maplocalleader="\\"
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" }}}

" netrw {{{

let netrw_altv=1
let netrw_banner=0
let netrw_browse_split=0
let netrw_winsize=75
let netrw_bufsettings='noma nomod nu nobl nowrap ro'

" }}}

" remaps {{{

nnoremap <leader>, :Ex<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <Tab> :bn<CR>
nnoremap <S-Tab> :bp<CR>
nnoremap <leader>gg :FloatermNew --wintype=float --height=0.9 --width=0.9 lazygit<CR>
nnoremap <leader>fn :FloatermNew --wintype=float --height=0.9 --width=0.9
nnoremap <leader>tn :tabnew<CR>
nnoremap <leader>tt :FloatermToggle<CR>
nnoremap <leader>t. :tabnext<CR>
nnoremap <leader>t, :tabprev<CR>
nnoremap <leader>tc :tabclose<CR>
nnoremap <leader>so :so ~/.vimrc<CR>
nnoremap <leader>u :UndotreeToggle<CR>
nnoremap <silent> <leader>ca :wa <bar> %bd <bar> e# <bar> bd# <CR><CR>

nnoremap gd :LspDefinition<CR>
nnoremap gr :LspReferences<CR>
nnoremap K :LspHover<CR>
nnoremap ]d :LspNextDiagnostic<CR>
nnoremap [d :LspPreviousDiagnostic<CR>

nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap G Gzz

nnoremap <C-s> :w<CR>
" nnoremap <C-a> ggVG

tnoremap <localleader><Esc> <C-\><C-n>

" move lines around in visual mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

" }}}

" vim-plug {{{

call plug#begin()

    Plug 'mangeshrex/everblush.vim'
    Plug 'itchyny/lightline.vim'
    Plug 'https://github.com/tpope/vim-fugitive'
    Plug 'https://github.com/ghifarit53/tokyonight-vim'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'voldikss/vim-floaterm'
    Plug 'mbbill/undotree'
    Plug 'airblade/vim-gitgutter'
    Plug 'prabirshrestha/vim-lsp'
    Plug 'mattn/vim-lsp-settings'
    Plug 'prabirshrestha/asyncomplete.vim'
    Plug 'prabirshrestha/asyncomplete-lsp.vim'
    Plug 'vim-test/vim-test'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'

call plug#end()

" }}}

" plugin vars {{{

let g:lightline = {
      \ 'colorscheme': 'tokyonight',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component': {
      \   'lineinfo': '%3l:%-2v%<',
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }
let g:fzf_preview_window = ['right,50%', 'ctrl-/']
let g:tokyonight_transparent_background = 1
let g:floaterm_wintype = 'vsplit'
let g:floaterm_width = 0.5
let g:undotree_SetFocusWhenToggle = 1
let g:test#strategy = 'floaterm'
let g:ctrlp_show_hidden = 1
let g:floaterm_giteditor = 'nvim'
let g:lsp_diagnostics_echo_cursor = 1

" }}}

" misc {{{

syntax on
colorscheme tokyonight

" }}}
