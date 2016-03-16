" Neobundle {{{
set nocompatible
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

 " execute pathogen#infect()

call neobundle#begin(expand('/Users/ruipgil/.vim/bundle'))

NeoBundleFetch 'Shougo/neobundle.vim' " Neobundle manages Neobundle
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'

" General
NeoBundle 'chaoren/vim-wordmotion'
NeoBundle 'scrooloose/nerdcommenter'

" File navigation
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'scrooloose/nerdtree'

" Colors, and and shapes
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'vim-airline/vim-airline'
NeoBundle 'vim-airline/vim-airline-themes'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'myint/syntastic-extras'
NeoBundle 'editorconfig/editorconfig-vim'
NeoBundle 'edkolev/tmuxline.vim'

NeoBundle 'junegunn/goyo.vim'

" Language specific
NeoBundle 'tpope/vim-markdown'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'mxw/vim-jsx' " Requires pangloss/vim-javascript
NeoBundle 'ekalinin/Dockerfile.vim'

" Evaluating
"NeoBundle 'jelera/vim-javascript-syntax'
NeoBundle 'tpope/vim-git'
"NeoBundle 'tpope/vim-fugitive'
"NeoBundle 'tpope/vim-surround'
"NeoBundle 'godlygeek/tabular'

call neobundle#end()

filetype plugin indent on

NeoBundleCheck " auto install
" }}}

let mapleader=","

set history=500 " lines to remember
set autoread " reload when file is changed from the outside
set number " show line number
" Set 7 lines to the cursor - when moving vertically using j/k
set scrolloff=7
set wildmenu " shows wild menu
set ruler " current position
set cmdheight=2 " height of the command bar
set hid " buffer becomes hidden when it is abandoned
 " fixes backspace
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set mouse=a " a mouse!
set ignorecase " ignore case when searching
set smartcase " try to guess cases when searching
set hlsearch " highlight search results
set incsearch " incremental search
set lazyredraw
set magic " on regular expressions
set showmatch " matching brackets
set mat=2 " matching brackets matching blink speed
set relativenumber " relative numbers

" Syntax highlighting {{{
" Enable syntax highlighting
syntax enable
set t_Co=256
set background=light
colorscheme solarized
" }}}

set encoding=utf8
set ffs=unix,dos,mac " Unix as the standard file type

" Local directories {{{
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
set undodir=~/.vim/undo
" }}}

set smarttab
set lbr " words don't get cut on linebreaks
set tw=500 " linebreak on 500 chars

set ai " auto indent
set wrap " wrap lines

set laststatus=2

set showcmd    " show command in bottom bar
" highlight current line
set cursorline
nnoremap <leader><space> :nohlsearch<CR> " turn off search highlight

set clipboard=unnamed " All yank commands now go to mac clipboard
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_ " ws chars
set list " show white spaces
set suffixes=.bak,~,.swp,.swo,.o,.d,.info,.aux,.log,.dvi,.pdf,.bin,.bbl,.blg,.brf,.cb,.dmg,.exe,.ind,.idx,.ilg,.inx,.out,.toc,.pyc,.pyd,.dll
set shell=/bin/sh " Use /bin/sh for executing shell commands
set visualbell " Use visual bell instead of audible bell (annnnnoying)

set wildignore+=.DS_Store
"set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd,*.o,*.obj,*.min.js
"set wildignore+=*/bower_components/*,*/node_modules/*
"set wildignore+=*/smarty/*,*/vendor/*,*/.git/*,*/.hg/*,*/.svn/*,*/.sass-cache/*,*/log/*,*/tmp/*,*/build/*,*/ckeditor/*,*/doc/*,*/source_maps/*,*/dist/*
set wildmode=list:longest " Complete only until point of ambiguity
set wrapscan " Searches wrap around end of file

map <leader>ss :setlocal spell!<cr> " toggle spell checking

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm
" 0 goes to the first non-blank char
map 0 ^

" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif



" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>

map j gj
map k gk
inoremap jk <esc> " jk is escape
" Avoid too many typos
inoremap Jk <esc>
inoremap jK <esc>
inoremap JK <esc>
" <space> to search
map <space> /
" ctrl-<space> to search backwards
map <c-space> ?

map <silent> <leader><cr> :noh<cr> " Disable highlight when <leader><cr> is pressed

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
map <leader>bd :Bclose<cr> " Close the current buffer
map <leader>ba :bufdo bd<cr> " Close all the buffers

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Avoid garbled characters in Chinese language windows OS
let $LANG='en'
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim



" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" Configuration settings -------------------------------------------------------------

" General {{{

map <leader>vimrc :tabe ~/.vimrc
autocmd bufwritepost ~/.vimrc source $MYVIMRC | AirlineRefresh

" Remap :W to :w {{{
command! W w
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


" Plugins settings -------------------------------------------------------------

" Airline.vim {{{
augroup AirlineConfig
  autocmd!
  let g:airline_powerline_fonts = 1
  let g:airline#extensions#syntastic#enabled = 1
  let g:airline#extensions#tabline#buffer_nr_format = '%s '
  let g:airline#extensions#tabline#buffer_nr_show = 1
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#fnamecollapse = 0
  let g:airline#extensions#tabline#fnamemod = ':t'
augroup END
" }}}


" Syntastic.vim {{{
  let g:syntastic_error_symbol = '✗'
  let g:syntastic_warning_symbol = '⚠'
  let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*

  " Language checkers {{{
  let g:syntastic_aggregate_errors = 1
  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_make_checkers = ['gnumake']
  let g:syntastic_gitcommit_checkers = ['language_check']
  let g:syntastic_python_checkers = ['pyflakes_with_warnings']
  let g:syntastic_disabled_filetypes=['java']
  let g:syntastic_javascript_checkers = ['eslint']
  "let g:syntastic_text_checkers = ['language-check']
  "let g:syntastic_markdown_checkers = ['language-check']
  "let g:syntastic_plaintex_checkers = ['language-check']
  " }}}
" }}}

" EditorConfig {{{
augroup editorconfig_config
  autocmd!
  let g:EditorConfig_exclude_patterns = ['fugitive://.*']
augroup END
" }}}

" Filetype ----------------------------
filetype plugin indent on

" JSON {{{
augroup filetype_json
  autocmd!
  au BufRead,BufNewFile *.json set ft=json syntax=javascript g:syntastic_javascript_checkers=['json_tool']
augroup END
" }}}

" Markdown {{{
augroup filetype_markdown
  autocmd!
  let g:markdown_fenced_languages = ['ruby', 'html', 'javascript', 'css', 'erb=eruby.html', 'bash=sh']

augroup END
" }}}

" XML {{{
augroup filetype_xml
  autocmd!
  au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"
augroup END
" }}}

" Fish {{{
augroup filetype_fish
  autocmd!
  au BufRead,BufNewFile *.fish set ft=sh
augroup END
" }}}

" ZSH {{{
augroup filetype_zsh
  autocmd!
  au BufRead,BufNewFile .zsh_rc,.functions,.commonrc set ft=zsh
augroup END
" }}}
