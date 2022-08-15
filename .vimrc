set nocompatible              " be iMproved, required

" Make the switch to Plug
" https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'ctrlpvim/ctrlp.vim'
Plug 'rking/ag.vim'
Plug 'tpope/vim-fugitive'
Plug 'vim-scripts/vim-auto-save'
Plug 'ervandew/supertab'
Plug 'ntpeters/vim-better-whitespace'
Plug 'cormacrelf/vim-colors-github'
Plug 'elixir-editors/vim-elixir'
Plug 'slashmili/alchemist.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'rodrigore/coc-tailwind-intellisense', {'do': 'npm install'}
" Plug 'elixir-lsp/coc-elixir', {'do': 'yarn install && yarn prepack'}
call plug#end()

" syntax off               " syntax highlighting
syntax on               " syntax highlighting
set backspace=2         " backspace in insert mode works like normal editor
filetype indent on      " activates indenting for files
set autoindent          " auto indenting
set number              " line numbers
" try without color scheme
" colorscheme desert      " colorscheme desert
" colorscheme delek      " colorscheme delek
" colorscheme github
set nobackup            " get rid of anoying ~file

set runtimepath^=~/.vim/bundle/ctrlp.vim

set clipboard=unnamed

set tabstop=2       " The width of a TAB is set to 2.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 2.
set shiftwidth=2    " Indents will have a width of 2
set softtabstop=2   " Sets the number of columns for a TAB
set expandtab       " Expand TABs to spaces

let NERDTreeShowHidden=1
let g:NERDTreeNodeDelimiter = "\u00a0"
let NERDTreeShowLineNumbers=1 " Show line numbers inside the NERDTree frame

let g:ctrlp_max_files=0
let g:auto_save = 1 " autosave on startup
let g:auto_save_in_insert_mode = 0 " does not save while in insert mode

abbr require require IEx; IEx.pry<Esc>

" folding settings
" Then you can toggle folding with za. You can fold everything with zM and
" unfold everything with zR. zm and zr can be used to get those folds just
" right. Always remember the almighty help file at “help :folding” if you get
" stuck.
" https://stackoverflow.com/a/10644424/3163631
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use

" no highlights
nnoremap <silent> fn :noh<CR>
