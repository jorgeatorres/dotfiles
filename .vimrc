
set nocompatible        " fuck vi
set autoread            " reload changed files
set fileformats=unix,dos,mac
set modeline

set nobackup            " backup is for pussies
set nowritebackup       " (idem)
set noswapfile
set backupdir=~/.vim/backup

" visual stuff
syntax on                       " syntax hl
set number                      " line numbers
set showmatch                   " show matching brackets
set ruler                       " show cursor position
set wildmenu                    " use wild menu for tab-completion

set backspace=indent,eol,start  " backspacing over everything
set whichwrap+=<,>,[,]          " cursor keys move to prev/next lines too

set shortmess=aAI               " use all the abbreviations, hide intro msg, etc.
set report=0
set nostartofline               " don't move the cursor to the start of lines
set incsearch                   " incremental search
set nohlsearch                  " don't highlight matches

set ignorecase                  " ignore case when searching
set smartcase                   " don't ignore case when pattern is not lowercase
                                " show trailing whitespace
set list listchars=tab:»·,trail:·

set title                       " set filename as terminal title
set titleold=

" formatting
set autoindent                  " automatic indentation
set smartindent
set nowrap                      " don't wrap lines
set tabstop=4
set softtabstop=4
set expandtab                   " expand tabs to spaces
set shiftwidth=4                " autoindent step
set formatoptions+=n            " recognize numbered lists

"set enc=utf-8
"set fenc=utf-8
"

" file-type specific config.
au BufRead,BufNewFile *.module setf php     " drupal modules
au BufRead,BufNewFile *.install setf php    " drupal modules

" gvim config.
if has("gui_running")
"    set guifont=Monaco:h12
    set guifont=Consolas:h13
    set guioptions-=T
    set lines=40
    set columns=100
    set mousemodel=popup
    colorscheme molokai
endif
