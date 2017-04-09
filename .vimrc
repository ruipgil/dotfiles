" Neobundle {{{
set nocompatible
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

 " execute pathogen#infect()

call neobundle#begin(expand('~/.vim/bundle'))

NeoBundleFetch 'Shougo/neobundle.vim' " Neobundle manages Neobundle
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'

" General
NeoBundle 'chaoren/vim-wordmotion'
" NeoBundle 'scrooloose/nerdcommenter'
" More targets
" + ci$ to change inside $
" + cia to change inside argument
" can be used with numeration
NeoBundle 'wellle/targets.vim'
" Comment easily: gc[c|{n}{direction}]
NeoBundle 'tomtom/tcomment_vim'
" Expand or contract arguments (e.g. JSON, function parameters)
" <leader>a
NeoBundle 'FooSoft/vim-argwrap'

" File navigation
" NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'qpkorr/vim-bufkill'

" Colors, and and shapes
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'ashfinal/vim-colors-violet'
NeoBundle 'sonph/onehalf'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'vim-airline/vim-airline'
NeoBundle 'vim-airline/vim-airline-themes'
" NeoBundle 'scrooloose/syntastic'
NeoBundle 'myint/syntastic-extras'
NeoBundle 'editorconfig/editorconfig-vim'
NeoBundle 'edkolev/tmuxline.vim'
NeoBundle 'christoomey/vim-tmux-navigator'

NeoBundle 'junegunn/goyo.vim'

" Language specific
NeoBundle 'tpope/vim-markdown'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'mxw/vim-jsx' " Requires pangloss/vim-javascript
NeoBundle 'ekalinin/Dockerfile.vim'

" Evaluating
"NeoBundle 'jelera/vim-javascript-syntax'
NeoBundle 'tpope/vim-git'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-surround'
" NeoBundle 'godlygeek/tabular'
NeoBundle 'kballard/vim-swift', { 'filetypes': 'swift', 'unite_sources': ['swift/device', 'swift/developer_dir'] }
"NeoBundle 'shougo/unite.vim'
NeoBundle 'Shougo/deoplete.nvim'
let g:deoplete#enable_at_startup = 1
NeoBundle 'majutsushi/tagbar'
" NeoBundle 'elzr/vim-json'
" NeoBundle 'christoomey/vim-sort-motion'
NeoBundle 'neomake/neomake'
NeoBundle 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
NeoBundle 'junegunn/fzf.vim'
NeoBundle 'Yggdroot/indentLine'

NeoBundle 'mindriot101/vim-yapf'
NeoBundle 'fatih/vim-go'

" let g:neomake_python_pylint_maker = {
"   \ 'args': ['--verbose'],
"   \ 'errorformat': '%A%f: line %l\, col %v\, %m \(%t%*\d\)',
"   \ }
" let g:neomake_python_enabled_makers = ['pylint']
let g:neomake_python_enabled_makers = ['pep8']
let g:neomake_javascript_enabled_makers = ['eslint']

autocmd! BufWritePost,BufEnter  * Neomake


call neobundle#end()


function TabToggle()
  if &expandtab
    set shiftwidth=8
    set softtabstop=0
    set noexpandtab
  else
    set shiftwidth=4
    set softtabstop=4
    set expandtab
  endif
endfunction


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
set background=dark
colorscheme solarized
" colorscheme onehalfdark
" }}}

if has('vim_starting')
  set encoding=utf8
endif
set ffs=unix,dos,mac " Unix as the standard file type

" Local directories {{{
set backupdir=~/.vim/backups
" set directory=~/.vim/swaps
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
set wildignore+=*.pyc
"set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd,*.o,*.obj,*.min.js
"set wildignore+=*/bower_components/*,*/node_modules/*
"set wildignore+=*/smarty/*,*/vendor/*,*/.git/*,*/.hg/*,*/.svn/*,*/.sass-cache/*,*/log/*,*/tmp/*,*/build/*,*/ckeditor/*,*/doc/*,*/source_maps/*,*/dist/*
set wildmode=longest,list,full " Complete only until point of ambiguity
set wrapscan " Searches wrap around end of file

" More natural splits
set splitbelow
set splitright

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

" Split pane vertically with |, and horizontally with _
nnoremap <bar> :vsplit<cr>
nnoremap _ :split<cr>

" To resize panes:
" <C-W>+/- for height
" <C-W>>/< for width
" <C-W>= to set equal sizes
" <C-W>c to close
"
" faster resize,
" :[vertical] resize [+|-]N
"
" Max splits
" <C-W>|/_ for vertical and horizontal
" <C-W>R switch panes
" <C-W>o close all but this one

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
" jk is escape
inoremap jk <esc>
" Avoid too many typos
inoremap Jk <esc>
inoremap jK <esc>
inoremap JK <esc>

map <C-p> :FZF<enter>

" Better command line editing
" cnoremap <C-j> <t_kd>
" cnoremap <C-k> <t_ku>
" cnoremap <C-a> <Home>
" cnoremap <C-e> <End>

" <space> to search
map <space> /
" ctrl-<space> to search backwards
map <c-space> ?

map <silent> <leader><cr> :noh<cr> " Disable highlight when <leader><cr> is pressed

" Smart way to move between windows
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
if has('nvim')
  " NeoVim is bugged when it comes to C-h remapping
  nnoremap <BS> <C-W>h
else
  nnoremap <C-h> <C-W>h
endif
nnoremap <C-l> <C-W>l
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


" Plugins settings -------------------------------------------------------------

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

" Filetype ----------------------------
filetype plugin indent on

" JSON {{{
" augroup filetype_json
"   autocmd!
"   au BufRead,BufNewFile *.json set ft=json syntax=javascript let g:syntastic_javascript_checkers = ['jsonval']
" augroup END
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

