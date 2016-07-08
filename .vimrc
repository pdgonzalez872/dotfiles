set nocompatible              " be iMproved, required

set rtp+=~/.vim/bundle/Vundle.vim

" set the runtime path to include Vundle and initialize
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'elixir-lang/vim-elixir'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-scripts/vim-auto-save'
Plugin 'tpope/vim-commentary'
Plugin 'ervandew/supertab'
Plugin 'rking/ag.vim'
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
let g:auto_save = 1 " autosave on startup
let g:auto_save_in_insert_mode = 0 " does not save while in insert mode

" alias generate_gem_ctags="ctags -R --languages=ruby --exclude=.git --exclude=log . $(bundle list --paths)"

set shortmess=a " per https://github.com/spf13/spf13-vim/issues/540

set backupdir=~/.vim/.backup//
set directory=~/.vim/.swp//
set undodir=~/.vim/.undo//
