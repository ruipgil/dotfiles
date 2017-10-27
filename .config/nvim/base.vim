filetype plugin indent on


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
nnoremap <silent> <Leader>bd :Bclose<CR>
" map <leader>bd :Bclose<cr> " Close the current buffer
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
