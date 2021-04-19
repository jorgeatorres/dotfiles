noremap Q <nop>

" More clever navigation.
nnoremap 0 g0
nnoremap $ g$
nnoremap j gj
nnoremap k gk

" Visual shifting.
vnoremap < <gv
vnoremap > >gv

imap jj <Esc>

" Navigate through buffers using <Leader><,> and <Leader><.>
map <Leader>, :bn<CR>
map <Leader>. :bn<CR>

" Ctrl + Space for omnifunc automcomplete.
imap <C-Space> <C-X><C-O>

" Typing %% expands to the path of the current file.
cmap %% <C-R>=expand("%:h") . "/" <CR>

" gss -> Git status.
nnoremap <silent> gss :Gstatus<CR>

" Make Tab and Enter select inside the ins-menu.
inoremap <expr> <Tab> pumvisible() ? "\<C-y>" : "\<Tab>"
inoremap <expr> <CR>  pumvisible() ? "\<C-y>" : "\<CR>"

" ,a is for Ack.
"nnoremap <Leader>a :Ack!<Space>''<Left>

" ,A searches the word under the cursor inside the project.
"nnoremap <Leader>A :Ack! <cword><CR>

nmap <Leader>t :CtrlP<CR>

" Ctrl-P with Cmd-T, Cmd-E, Cmd-R.
" nmap <D-t> :CtrlP<CR>
" imap <D-t> <Esc><D-t>

"nmap <D-e> :CtrlPBuffer<CR>
""nmap <D-r> :CtrlPFunky<CR>
"imap <D-e> <Esc><D-e>
"imap <D-r> <Esc><D-r>

"" imap <Leader><Leader>t <Esc><Leader>t
"" imap <Leader><Leader>r <Esc><Leader>r
"" imap <Leader><Leader>e <Esc><Leader>e

" nnoremap <D-r> :CtrlPFunky<CR>
" nnoremap <D-R> :execute 'CtrlPFunky ' . expand('<cword>')<CR>

" From wvega/dotfiles-next:
" " relative path  (src/foo.txt)
" nnoremap <leader>cr :let @*=fnamemodify(expand("%"),":.")<CR>
" " absolute path  (/something/src/foo.txt)
" nnoremap <leader>cp :let @*=expand("%:p")<CR>
" " filename       (foo.txt)
" nnoremap <leader>cf :let @*=expand("%:t")<CR>
" " directory name (/something/src)
" nnoremap <leader>cd :let @*=expand("%:p:h")<CR>
" " open current directory on netrw
" nnoremap <leader>ed :execute 'e ' . expand("%:p:h")<CR>
