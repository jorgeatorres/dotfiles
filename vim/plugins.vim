let g:tcomment#filetype#guess_php=1

let delimitMate_expand_space=1

let g:gutentags_cache_dir = $HOME .'/.cache/vim-gutentags' " Store tags files outside of project directories.

let g:ackprg = 'rg --vimgrep --ignore-vcs --no-heading --smart-case --iglob !node_modules/ --iglob !.git/ --iglob !.DS_Store --iglob !vendor/ --iglob !tmp/ --iglob !tags --sort-files'"

" CtrlP.
let g:ctrlp_use_caching = 0
let g:ctrlp_user_command = 'rg %s --files --color=never --glob "" --no-ignore-vcs --iglob !.git/ --iglob !node_modules/ --iglob !.DS_Store --iglob !vendor/ --iglob !tmp/'
let g:ctrlp_match_window = 'top,order:ttb,min:1,max:20'
let g:ctrlp_show_hidden = 0
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
let g:ctrlp_max_files = 0
"let g:ctrlp_extensions = ['']
let g:ctrlp_extensions = ['funky']
let g:ctrlp_open_multiple_files = 'ij'
let g:ctrlp_working_path_mode = ''

" ctrlsf.
let g:ctrlsf_auto_close = 0
let g:ctrlsf_position = 'bottom'
" let g:ctrlsf_winsize = '200'

let g:phpcomplete_mappings = {
  \ 'jump_to_def': '<C-]>',
  \ 'jump_to_def_split': '',
  \ 'jump_to_def_vsplit': '',
  \ 'jump_to_def_tabnew': '',
  \}

" buftabline.
let g:buftabline_show = 1
let g:buftabline_separators = 1
let g:buftabline_plug_max = 5

" vim-session.
let g:session_autoload = 'no'
let g:session_autosave = 'yes'
let g:session_autosave_silent = 1
let g:session_directory = '~/.cache/vim-session/'

" vim-rooter.
let g:rooter_patterns = ['.project']
let g:rooter_silent_chdir = 1

" completor.vim.
" let g:completor_complete_options = 'menu,menuone,noinsert'
" let g:completor_completion_delay = 500
" let g:completor_blacklist = ['tagbar', 'netrw', 'gitcommit', 'gitrebase']
" let g:completor_php_omni_trigger = '([$\w]+|use\s*|->[$\w]*|::[$\w]*|implements\s*|extends\s*|class\s+[$\w]+|new\s*)$'
" let g:completor_python_binary = '/usr/local/bin/python3'

" CtrlPFunky
" let g:ctrlp_funky_matchtype = 'path'
" let g:ctrlp_funky_syntax_highlight = 1
