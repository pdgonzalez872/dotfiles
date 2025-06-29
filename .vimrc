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
Plug 'alvan/vim-closetag'
Plug 'slashmili/alchemist.vim'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'rodrigore/coc-tailwind-intellisense', {'do': 'npm install'}
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

" Add file types for HEEx and LEEx
au BufRead,BufNewFile *.heex,*.leex set filetype=eelixir
let g:closetag_filetypes = 'html,xhtml,phtml,eelixir,elixir'

let g:ctrlp_max_files=0
let g:auto_save = 1 " autosave on startup
let g:auto_save_in_insert_mode = 0 " does not save while in insert mode

" Repetition
abbr require require Logger<Esc>

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

" auto formatting

" impl 1 - https://www.baeldung.com/linux/vi-automatic-commands-reloading-file-contents
" autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() !~ '(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif
" autocmd FileChangedShellPost * echohl WarningMsg | echo "Buffer refreshed with external changes." | echohl None

" impl 2 - ChatGPT after some discussion
" Set autoread to reload files automatically when they're changed externally
set autoread

" Set up a timer to periodically check for changes in the file
set updatetime=500 " Check every milliseconds

" Function to reload the buffer if the file was changed externally
function! RefreshBuffer()
  if getbufvar(bufnr(''), '&mod') == '0'
    checktime
  endif
endfunction

" Use the CursorHold event to call the RefreshBuffer function
autocmd CursorHold * call RefreshBuffer()
" end impl 2
"
augroup TrimWhitespace
  autocmd!
  autocmd BufWritePre * %s/\s\+$//e
augroup END
