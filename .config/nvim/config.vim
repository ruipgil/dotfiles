" General {{{

let g:loaded_python2_provider = 1

" map <leader>vimrc :tabe $MYVIMRC
autocmd bufwritepost $MYVIMRC source $MYVIMRC | AirlineRefresh

" Remap :W to :w {{{
command! W w
" }}}

" Moves throught wraped lines {{{
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
" }}}

" Paste toggle (,p) {{{
set pastetoggle=<leader>p
map <leader>p :set invpaste paste?<CR>
" }}}

" Yank from cursor to end of line {{{
nnoremap Y y$
" }}}

" Insert newline {{{
map <leader><Enter> o<ESC>
" }}}

" Disable paste mode when leaving Inser Mode
" au InsertLeave * set nopaste

" Search and replace word under cursor (,*) {{{
nnoremap <leader>* :%s/\<<C-r><C-w>\>//<Left>
vnoremap <leader>* "hy:%s/\V<C-r>h//<left>
" }}}

" Strip trailing whitespace (,ss) {{{
function! StripWhitespace () " {{{
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  :%s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction " }}}
noremap <leader>ss :call StripWhitespace ()<CR>
" }}}

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("Ag \"" . l:pattern . "\" " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

" Word Processor Mode {{{
augroup word_processor_mode
  autocmd!

  function! WordProcessorMode() " {{{
    setlocal formatoptions=t1
    setlocal spell spelllang=en_us
    setlocal linebreak
    setlocal noexpandtab
    Goyo 100
  endfunction " }}}
  com! WP call WordProcessorMode()

  function! WordProcessorModePt() " {{{
    setlocal formatoptions=t1
    setlocal spell spelllang=pt_pt
    setlocal noexpandtab
    setlocal linebreak
    Goyo 100
  endfunction " }}}
  com! WPT call WordProcessorModePt()
augroup END
" }}}

" Standard format js
augroup format_js
  autocmd!

  " TODO: check file type
  command! Fmt silent !standard-format % --write
augroup END
" }}}

function! Tabs2Spaces() " {{{
  setlocal expandtab
  retab
endfunction " }}}
command! T2s call !Tabs2Spaces()

" let g:vim_json_syntax_conceal = 0
set grepprg=rg\ --vimgrep

" TODO vimrc as a dynamic var
command Vimrc e ~/.vimrc
command Vsource source ~/.vimrc
