" Required for Vundle.
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

"
" Installed plugins. {{
"
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'rking/ag.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'JazzCore/ctrlp-cmatcher'
Plugin 'Raimondi/delimitMate'
Plugin 'bling/vim-airline'
"Plugin 'terryma/vim-multiple-cursors'
Plugin 'henrik/vim-reveal-in-finder'
Plugin 'myusuf3/numbers.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-eunuch'
Plugin 'tacahiroy/ctrlp-funky'
"Plugin 'SirVer/ultisnips'
"Plugin 'honza/vim-snippets'
Plugin 'shawncplus/phpcomplete.vim'
Plugin 'vim-scripts/matchit.zip'
Plugin 'mtth/scratch.vim'
Plugin 'junegunn/goyo.vim'
Plugin 'tpope/vim-surround' "ds, cs, yss
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'christophermca/meta5'
Plugin 'skwp/greplace.vim'
Plugin 'tomtom/tcomment_vim' "gcc, gc{motion}

" Colorschemes
Plugin 'NLKNguyen/papercolor-theme'
Plugin 'chriskempson/base16-vim'

call vundle#end()
"
" }}
"

"
" Plugins config. {{
"

" Use Silver Searcher instead of grep
set grepprg=ag
let g:grep_cmd_opts = '--line-numbers --noheading'

" CTRL-P config.
let g:ctrlp_match_window_bottom = 0
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_max_height = 15
let g:ctrlp_show_hidden = 0
let g:ctrlp_match_func = {'match' : 'matcher#cmatch' }
let g:ctrlp_max_files = 0
let g:ctrlp_map = ''
let g:ctrlp_custom_ignore = {
    \ 'dir': '\v[\/](\.git|\.hg|\.svn|www|wordpress\-i18n)$',
    \ 'file': '\v\.(exe|so|dll|pyc|gif|png|jpg|mo)$'
\}
let g:ctrlp_extensions = ['funky']
"let g:ctrlp_funky_syntax_highlight = 1

" vim-indent-guides.
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size=1
let g:indent_guides_color_change_percent=4
let g:indent_guides_start_level=3

"
" }}
"
