"unlet! skip_defaults_vim source $VIMRUNTIME/defaults.vim

"runtime! archlinux.vim

"#### PLUGINS ####
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required

Plugin 'VundleVim/Vundle.vim'
" themes
Plugin 'morhetz/gruvbox'
Plugin 'mhartington/oceanic-next'
Plugin 'tomasiser/vim-code-dark'
Plugin 'arcticicestudio/nord-vim'
" status bar
Plugin 'itchyny/lightline.vim' 
" vifm
Plugin 'vifm/vifm.vim' 
"indent
Plugin 'yggdroot/indentline'
" prettier
Plugin 'prettier/vim-prettier'
" nerdTree
Plugin 'scrooloose/nerdtree'
" snippets
Plugin 'honza/vim-snippets'
" youcopleteme ( auto complete )
"Plugin 'valloric/youcompleteme'
" hardmod
Plugin 'wikitopian/hardmode'
" status line
Plugin 'mattn/emmet-vim'
" Clarify the colors
Plugin 'lilydjwg/colorizer'
" line number
Plugin 'jeffkreeftmeijer/vim-numbertoggle'

call vundle#end()
filetype plugin indent on    " required

" Set Theme
colorscheme gruvbox
set background=dark

" ### bases ####
syntax on

set noerrorbells
" tabs
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab " allow to use tabs
set number " number line
" wrap
"set nowrap
"set ignorecase
"set smartcase
"set smartindent
set incsearch " highlight only first search when typing
set hlsearch " highlight all search after pres Enter
"set cursorline " highlight horizontal line
"set cursorcolumn " highlight vertical line 
set laststatus=2 " lightline
set noshowmode " hiddin mode name under status bar

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

" ### PRETTIER ###

" Max line length that prettier will wrap on: a number or 'auto' (use
" textwidth).
" default: 'auto'
let g:prettier#config#print_width = 'auto'

" number of spaces per indentation level: a number or 'auto' (use
" softtabstop)
" default: 'auto'
let g:prettier#config#tab_width = 'auto'

" use tabs instead of spaces: true, false, or auto (use the expandtab setting).
" default: 'auto'
let g:prettier#config#use_tabs = 'auto'

" flow|babylon|typescript|css|less|scss|json|graphql|markdown or empty string
" (let prettier choose).
" default: ''
let g:prettier#config#parser = ''

" cli-override|file-override|prefer-file
" default: 'file-override'
let g:prettier#config#config_precedence = 'file-override'

" always|never|preserve
" default: 'preserve'
let g:prettier#config#prose_wrap = 'preserve'

" css|strict|ignore
" default: 'css'
let g:prettier#config#html_whitespace_sensitivity = 'css'

" false|true
" default: 'false'
let g:prettier#config#require_pragma = 'false'




let g:HardMode_level = 'wannabe'
let g:HardMode_hardmodeMsg = 'Don''t use this!'
autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()

" ### EMMET ###
let g:user_emmet_leader_key='<C-Z>'

