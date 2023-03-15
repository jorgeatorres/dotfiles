" vim:set ts=2 sts=2 sw=2 expandtab:

" Reuse nvim's runtimepath and packpath in vim.
if ! has('nvim')
	set runtimepath-=~/.vim
	\ runtimepath^=~/.local/share/nvim/site runtimepath^=~/.vim
	\ runtimepath-=~/.vim/after
	\ runtimepath+=~/.local/share/nvim/site/after runtimepath+=~/.vim/after
	let &packpath = &runtimepath
end
