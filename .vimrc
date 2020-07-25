""" Vim option documentation
""" http://vimdoc.sourceforge.net/htmldoc/options.html

""" Vim tips
""" - gv - start visual with previous selection
"""
""" https://www.brianstorti.com/vim-registers/ - "0 is the register containing the last yank
""" https://til.hashrocket.com/posts/f37c34b7e3-vim-asterisk-search - * searches current word
""" https://stackoverflow.com/a/1550774 - prefix search/replace/etc. with \V for (basically) no regex
""" https://www.fprintf.net/vimCheatSheet.html
"""     - r {file} / r !{cmd} - insert {file} or stdout of {cmd} below the cursor
"""     - f/F{char} - go to the next occurrence of {char} to the right/left
"""     - t/T{char} - go to before the next occurrence of {char} to the right/left
"""     - V - visual mode, select whole lines
""" https://vim.fandom.com/wiki/Search_and_replace
"""     - :%s/foo/bar - replace first occurrence of foo on every line with bar
"""     - :%s/foo/bar/g - replace every occurence of foo with bar
"""
""" buffers (tips for using buffers: https://stackoverflow.com/a/26745051)
"""     - :new - create empty buffer
"""     - :e (edit) {file} - create new buffer for {file} and open it (* - wildcard, ** - any subdirectory)
"""     - :badd {file} - create new buffer for {file}
"""     - :ls - list existing buffers
"""     - :b (buffer){num/name} - switch to buffer with {num} or that contains {name} (tab completion)
"""         - :b4 - switch to buffer #4
"""         - :bn - switch to next buffer
"""         - :bp - switch to previous buffer
"""         - :bf - switch to first buffer
""          - :bl - switch to last buffer
"""     - :bd (bdelete) [num] - close buffer [num]/current buffer
"""
""" tabs
"""     - :tabe (tabedit) {file} - edit {file} in new tab
"""     - [num]gt - go to tab [num]/next tab
"""     - gT - go to previous tab
"""     - :tabc (tabclose) [num] - close tab[num] / current tab
"""
""" splits
"""     - :sp (split) [file] - split current file horizontally / open file and split
"""         - :sp | b 3 - splits buffer #3
"""         - :sp | b name - splits buffer with name
"""     - :vs (vsplit) [file] - split current file vertically / open file and split
"""     - <Ctrl-W> + ? - control splits
"""         - i/j/k/l - move between splits
"""         - q - close split

""""""""""
" General
""""""""""

set history=500

" Display line numbers
set number

" Display current line and column on bottom bar
set ruler

" Flash on error instead of sound
set noerrorbells
set visualbell

" Check for file changes when vim/current buffer gains focus
set autoread
autocmd FocusGained,BufEnter * checktime

" Enable vim tab completion
set wildmenu

" Allow mouse to change cursor location
set mouse=a

" Set minimum number of lines above/below cursor
set scrolloff=7

" Highlight trailing whitespace
" Show tabs with bar
set list listchars=tab:\│\ ,trail:·

set showcmd

""""""""""
" Remaps
""""""""""

let mapleader=" "
nnoremap <leader>w :w<CR>
nnoremap <leader>x :x<CR>
nnoremap <leader>q :q
nnoremap <leader>nh :noh<CR>

""""""""""
" Buffers / Tabs
""""""""""

" Always show tab line
set showtabline=2

" gb (goto buffer) - list loaded buffers, wait for which buffer to go to
nnoremap gb :ls<CR>:b<Space>

""""""""""
" Search
""""""""""

" Smart case-sensitivity for search (case-insensitive if lowercase, case-sensitive if uppercase exists)
set ignorecase
set smartcase

" Highlight search results
set hlsearch

" Search as you type
set incsearch

" Enable syntax highlighting
syntax enable

""""""""""
" Indentation
""""""""""

" Expand tab to spaces
set expandtab

" Delete 'shiftwidth' worth of spaces with backspace at start of line
" Make t
set smarttab

" Set tab to be 4 spaces
set shiftwidth=4
set tabstop=4

set autoindent

""""""""""
" Plugins (vim-plug)
""""""""""

call plug#begin('~/.vim/plugged')
Plug 'ycm-core/YouCompleteMe'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }
Plug 'chriskempson/base16-vim'
call plug#end()

" YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion = 1

""""""""""
" gvim
""""""""""

set guifont=SauceCodePro\ Nerd\ Font\ 13

"""""""""
" Themes
"""""""""
let base16colorspace=256

colorscheme base16-default-dark

" Enable transparency
hi Normal ctermbg=none
hi NonText ctermbg=none
