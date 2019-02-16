" dein.vim/deoplete.nvim settings
if &compatible
  set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

  call dein#add('Shougo/deoplete.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

let g:deoplete#enable_at_startup = 1
" end dein.vim/deoplete.nvim settings

filetype plugin on
set omnifunc=syntaxcomplete#Complete

set title
set clipboard=unnamed
set number
set numberwidth=1
set backspace=indent,eol,start
set background=dark
set cursorline

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set smartindent
highlight LineNR ctermfg=109
highlight Cursor ctermfg=15
highlight iCursor ctermfg=15

inoremap <silent> jj <ESC>
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
