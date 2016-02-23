" Command to reload VIM config.
command! ReloadConfig source ~/.vimrc

" Remove trailing spaces.
command! RemoveTrailingSpaces :%s/\s\+$//e

" Cursor line only in active window. (taken from http://codeyarns.com/2013/02/07/how-to-show-cursorline-only-in-active-window-of-vim/).
augroup CursorLineOnlyInActiveWindow
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

" Automatically create directories when saving (if needed).
autocmd BufWritePre * :silent! call mkdir(expand('%:p:h'), 'p')
