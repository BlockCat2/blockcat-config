"
"   W I M R C
"
"   @updated:   Mi 29 Jun 2012
"   @revision:  3
call plug#begin('~/.vim/plugged')

set nocompatible               " be iMproved
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'Valloric/YouCompleteMe'

call vundle#end()
filetype plugin indent on



set background=dark
colorscheme nucolors


"map caps:escape
"option "XkbdOptions" "caps:escape"
Plug 'junegunn/seoul256.vim'
call plug#end()
let g:seoul256_background = 233
colo seoul256

augroup resCur
autocmd!
autocmd BufReadPost * call setpos(".", getpos("'\""))
augroup END
let g:Powerline_symbols = 'fancy'
