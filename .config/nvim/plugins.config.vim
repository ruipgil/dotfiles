" Airline.vim {{{
augroup AirlineConfig
  autocmd!
  let g:airline_powerline_fonts = 1
  let g:airline#extensions#default#section_use_groupitems = 0
  let g:airline#extensions#syntastic#enabled = 1
  let g:airline#extensions#tabline#buffer_nr_format = '%s '
  let g:airline#extensions#tabline#buffer_nr_show = 1
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#fnamecollapse = 0
  let g:airline#extensions#tabline#fnamemod = ':t'
augroup END
" }}}

" let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|venv'

" Syntastic.vim {{{
  " let g:syntastic_error_symbol = '✗'
  " let g:syntastic_warning_symbol = '⚠'

  "set statusline+=%#warningmsg#
  "set statusline+=%{SyntasticStatuslineFlag()}
  "set statusline+=%*

  " Language checkers {{{
  " let g:syntastic_aggregate_errors = 1
  " let g:syntastic_always_populate_loc_list = 1
  " let g:syntastic_make_checkers = ['gnumake']
  " let g:syntastic_gitcommit_checkers = ['language_check']
  " let g:syntastic_python_checkers = ['pep8', 'pylint', 'pyflakes_with_warnings']
  " let g:syntastic_disabled_filetypes=['java']
  " let g:syntastic_javascript_checkers = ['eslint']

  "let g:syntastic_text_checkers = ['language-check']
  "let g:syntastic_markdown_checkers = ['language-check']
  "let g:syntastic_plaintex_checkers = ['language-check']
  " }}}
" }}}

function CenterPane()
  lefta vnew
  wincmd w
  exec 'vertical resize '. string(&columns * 0.75)
endfunction
nnoremap <leader>c :call CenterPane()<cr>

" EditorConfig {{{
augroup editorconfig_config
  autocmd!
  let g:EditorConfig_exclude_patterns = ['fugitive://.*']
augroup END
" }}}

" NERDTree {{{
augroup nerdtree_config
  autocmd!
  let NERDTreeIgnore = ['\.pyc$']
" }}}

" Unite {{{
nnoremap <Leader>f :Unite -start-insert file<CR>
" }}}

" ArgWrap {{{
nnoremap <silent> <leader>a :ArgWrap<CR>
" }}}

"let g:deoplete#enable_at_startup = 1

"" Let <Tab> also do completion
"inoremap <silent><expr> <Tab>
"\ pumvisible() ? "\<C-n>" :
"\ deoplete#mappings#manual_complete()

"" Close the documentation window when completion is done
"autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
function! s:fzf_statusline()
  " Override statusline as you like
  highlight fzf1 ctermfg=161 ctermbg=251
  highlight fzf2 ctermfg=23 ctermbg=251
  highlight fzf3 ctermfg=237 ctermbg=251
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction

autocmd! User FzfStatusLine call <SID>fzf_statusline()
let g:fzf_commands_expect = 'alt-enter,ctrl-x'

"" Key binding for yapf
:nnoremap <leader>y :Yapf<cr>

highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

" source: https://medium.com/@crashybang/supercharge-vim-with-fzf-and-ripgrep-d4661fc853d2
" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
" ^^^^^^^^ May cause problems on tmux+vim, but not tmux+neovim
" Fix for that:
" command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)

let g:ale_sign_column_always = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_sign_error = '✖︎'
let g:ale_sign_warning = '❂'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 1

let g:ale_virtualenv_dir_names = ['venv', 'venv3', 'venv2']

" Gitgutter
let g:gitgutter_sign_added = '•'
let g:gitgutter_sign_removed = '•'
let g:gitgutter_sign_modified = '•'
let g:gitgutter_sign_modified_removed = '▾'
let g:gitgutter_sign_removed_first_line = '▴'

" vim-commentary
autocmd FileType gitconfig setlocal commentstring=#\ %s
