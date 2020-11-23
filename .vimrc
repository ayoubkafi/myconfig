"unlet! skip_defaults_vim source $VIMRUNTIME/defaults.vim

"runtime! archlinux.vim

"#### PLUGINS ####
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'morhetz/gruvbox'
"Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'nanotech/jellybeans.vim'
Plugin 'sainnhe/vim-color-forest-night'
Plugin 'dracula/vim'
Plugin 'ryanoasis/vim-devicons'
Plugin 'neoclide/coc.nvim'
Plugin 'weirongxu/coc-explorer'
Plugin 'tomasiser/vim-code-dark'
Plugin 'arcticicestudio/nord-vim'
Plugin 'altercation/vim-colors-solarized'
"Plugin 'dart-lang/dart-vim-plugin'
Plugin 'itchyny/lightline.vim' 
Plugin 'vifm/vifm.vim' 
Plugin 'yggdroot/indentline'
Plugin 'scrooloose/nerdtree'
Plugin 'honza/vim-snippets'
Plugin 'wikitopian/hardmode'
Plugin 'mattn/emmet-vim'
Plugin 'lilydjwg/colorizer'
"Plugin 'jeffkreeftmeijer/vim-numbertoggle'
Plugin 'ajh17/vimcompletesme'
"Plugin 'valloric/youcompleteme'
"Plugin 'townk/vim-autoclose'
"Plugin 'ervandew/supertab'
"Plugin 'neoclide/coc.nvim'

call vundle#end()
filetype plugin indent on    " required

" ### bases ####
syntax on

" Set Theme
colorscheme gruvbox
set background=dark

let g:solarized_termcolors=256
let g:solarized_termtrans=1

set noerrorbells
" tabs
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab " allow to use tabs
set number " number line
"set nowrap
"set ignorecase
"set smartcase
"set smartindent
set incsearch " highlight only first search when typing
set hlsearch " highlight all search after pres Enter
set cursorline
"set cursorcolumn
set laststatus=2 " lightline
set noshowmode " hiddin mode name under status bar
"set mouse=a
nmap <c-l> :noh <CR>

" ### NerdTree ###
let g:NERDTreeWinSize=30 " window size
nmap <c-n> :NERDTreeToggle <CR>

augroup filetype_nerdtree
    au!
    au FileType nerdtree call s:disable_lightline_on_nerdtree()
    au WinEnter,BufWinEnter,TabEnter * call s:disable_lightline_on_nerdtree()
augroup END

fu s:disable_lightline_on_nerdtree() abort
    let nerdtree_winnr = index(map(range(1, winnr('$')), {_,v -> getbufvar(winbufnr(v), '&ft')}), 'nerdtree') + 1
    call timer_start(0, {-> nerdtree_winnr && setwinvar(nerdtree_winnr, '&stl', '%#Normal#')})
endfu

" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" ### HARD MODE ###
let g:HardMode_level = 'wannabe'
let g:HardMode_hardmodeMsg = 'Don''t use this!'
autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()

" ### EMMET ###
"let g:user_emmet_leader_key='<C-Z>'
let g:user_emmet_expandabbr_key='<Tab>'
imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")

" indent line
let g:indentLine_setConceal = 1
let g:indentLine_char = '|'


"let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=green ctermbg=8
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=0

let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ }
