" Lightline.vim {{{
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ }
let g:lightline.component_expand = {
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }
let g:lightline.component_type = {
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \ }
let g:lightline.active = { 'right': [[ 'linter_errors', 'linter_warnings', 'linter_ok' ]] }
" }}}
"
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
augroup END
" }}}

" ArgWrap {{{
nnoremap <silent> <leader>a :ArgWrap<CR>
" }}}

" FZF {{{
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
" }}}

" highlight ColorColumn ctermbg=magenta
" call matchadd('ColorColumn', '\%81v', 100)

" Ale {{{
let g:ale_sign_column_always = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_sign_error = '✖︎'
let g:ale_sign_warning = '❂'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 1
let g:ale_virtualenv_dir_names = ['venv', 'venv3', 'venv2']
" }}}

" Gitgutter {{{
let g:gitgutter_sign_added = '•'
let g:gitgutter_sign_removed = '•'
let g:gitgutter_sign_modified = '•'
let g:gitgutter_sign_modified_removed = '▾'
let g:gitgutter_sign_removed_first_line = '▴'
" }}}

" vim-commentary {{{
autocmd FileType gitconfig setlocal commentstring=#\ %s
" }}}
