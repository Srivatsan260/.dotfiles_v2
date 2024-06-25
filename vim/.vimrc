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
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap <C-o> <C-o>zz
nnoremap <C-i> <C-i>zz

nnoremap <C-s> :w<CR>
" nnoremap <C-a> ggVG

tnoremap <localleader><Esc> <C-\><C-n>

" move lines around in visual mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
vnoremap > >gv
vnoremap < <gv

" select all
nnoremap <leader>va <cmd>normal ggVG<CR>

" yank all
nnoremap <leader>ya <cmd>normal ggyG<C-o>zz<CR>

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

" window switching
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Floaterm
nnoremap <C-\> <cmd>FloatermToggle<CR>
tnoremap <C-\> <cmd>FloatermToggle<CR>

" delete without affecting registers
nnoremap <leader>D "_d

" paste without affecting registers
vnoremap p "_dP

" navigate quickfix
nnoremap <localleader>q <cmd>copen<CR>
nnoremap <localleader>. <cmd>cnext<CR>
nnoremap <localleader>, <cmd>cprev<CR>

" open zshrc and zshenv
nnoremap <leader>nz :e ~/.zshrc<CR>
nnoremap <leader>ne :e ~/.zshenv<CR>

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
" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
" let s:opam_share_dir = system("opam config var share")
" let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')
"
" let s:opam_configuration = {}
"
" function! OpamConfOcpIndent()
"   execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
" endfunction
" let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')
"
" function! OpamConfOcpIndex()
"   execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
" endfunction
" let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')
"
" function! OpamConfMerlin()
"   let l:dir = s:opam_share_dir . "/merlin/vim"
"   execute "set rtp+=" . l:dir
" endfunction
" let s:opam_configuration['merlin'] = function('OpamConfMerlin')
"
" let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
" let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
" let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
" for tool in s:opam_packages
"   " Respect package order (merlin should be after ocp-index)
"   if count(s:opam_available_tools, tool) > 0
"     call s:opam_configuration[tool]()
"   endif
" endfor
" " ## end of OPAM user-setup addition for vim / base ## keep this line
" " ## added by OPAM user-setup for vim / ocp-indent ## 727bab30a4293876e0820c7a2564453e ## you can edit, but keep this line
" if count(s:opam_available_tools,"ocp-indent") == 0
"   source "/Users/srivatsanramaswamy/.opam/default/share/ocp-indent/vim/indent/ocaml.vim"
" endif
" ## end of OPAM user-setup addition for vim / ocp-indent ## keep this line
