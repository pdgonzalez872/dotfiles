set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim

" set the runtime path to include Vundle and initialize
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plugin 'ctrlpvim/ctrlp'
Plugin 'elixir-lang/vim-elixir'
Plugin 'tpope/vim-fugitive'
call vundle#end()

syntax on               " syntax highlighting
set backspace=2         " backspace in insert mode works like normal editor
filetype indent on      " activates indenting for files
set autoindent          " auto indenting
set number              " line numbers
colorscheme desert      " colorscheme desert
set nobackup            " get rid of anoying ~file

set runtimepath^=~/.vim/bundle/ctrlp.vim
set clipboard=unnamed

set tabstop=4       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.
set shiftwidth=4    " Indents will have a width of 4
set softtabstop=4   " Sets the number of columns for a TAB
set expandtab       " Expand TABs to spaces

let g:ctrlp_max_files=0
