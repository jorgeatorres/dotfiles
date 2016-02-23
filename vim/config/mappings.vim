" A more clever navigation
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk

" Yank to the end of the line.
nnoremap Y y$

" Remap <leader> key.
let mapleader = ","

" Map ESC to jj
imap jj <ESC>

" Remap space bar to search.
:nmap <Space> /

" Navigate through buffers using Ctrl-Tab and Ctrl-Shift-Tab and also Cmd-1, Cmd-2 for buffers.
map <C-Tab> :bn<CR>
map <C-S-Tab> :bp<CR>

" Wipe out buffer with Cmd+W.
map <D-w> :bw<CR>

" Ctrl + Space for omnifunc automcplete.
imap <C-Space> <C-X><C-O>

" Ctrl-P
nmap <D-t> <Esc>:CtrlP<CR>
imap <D-t> <C-o><D-t>
nmap <D-r> <Esc>:CtrlPFunky<CR>
imap <D-r> <C-o><D-r>
nmap <D-e> <Esc>:CtrlPBuffer<CR>
imap <D-e> <C-o><D-e>

" File search (AG Silver Searcher).
map <Leader>fs :Ag!<Space>
