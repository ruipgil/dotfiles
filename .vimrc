" Neobundle {{{
if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

 " execute pathogen#infect()

call neobundle#begin(expand('/Users/ruipgil/.vim/bundle'))

NeoBundleFetch 'Shougo/neobundle.vim' " Neobundle manages Neobundle

NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'bling/vim-airline'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'editorconfig/editorconfig-vim'
NeoBundle 'godlygeek/tabular'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'tpope/vim-markdown'


call neobundle#end()

filetype plugin indent on

NeoBundleCheck " auto install
" }}}


filetype plugin on
filetype indent on " enable filetype plugins
set history=500 " lines to remember
set autoread " reload when file is changed from the outside
set number " show line number
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7
set wildmenu " shows wild menu
set ruler " current position
set cmdheight=2 " height of the command bar
set hid " buffer becomes hidden when it is abandoned
set backspace=eol,start,indent " fixes backspace (part 1)
set whichwrap+=<,>,h,l " fixes backspace (part 2)
if has('mouse')
  set mouse=a " a mouse!
endif
set ignorecase " ignore case when searching
set smartcase " try to guess cases when searching
set hlsearch " highlight search results
set incsearch " incremental search
set lazyredraw
set magic " on regular expressions
set showmatch " matching brackets
set mat=2 " matching brackets matching blink speed

" Enable syntax highlighting
syntax enable
" set foldcolumn=1 " extra margin to the left
set background=light
" let g:solarized_termcolors=256
" let g:solarized_visibility="high"
" let g:solarized_contrast="high"
colorscheme solarized

set encoding=utf8
set ffs=unix,dos,mac " Unix as the standard file type

" Turn off backup (TODO)
set nobackup
set nowb
set noswapfile

set smarttab
set lbr " words don't get cut on linebreaks
set tw=500 " linebreak on 500 chars

set ai " auto indent
set si " smart indent
set wrap " wrap lines

set laststatus=2

set showcmd    " show command in bottom bar
" set cursorline " highlight current line
nnoremap <leader><space> :nohlsearch<CR> " turn off search highlight

set clipboard=unnamed " All yank commands now go to mac clipboard
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_ " ws chars
set list " show white spaces
set suffixes=.bak,~,.swp,.swo,.o,.d,.info,.aux,.log,.dvi,.pdf,.bin,.bbl,.blg,.brf,.cb,.dmg,.exe,.ind,.idx,.ilg,.inx,.out,.toc,.pyc,.pyd,.dll
set shell=/bin/bash " Use /bin/sh for executing shell commands
set visualbell " Use visual bell instead of audible bell (annnnnoying)

set wildignore+=.DS_Store
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd,*.o,*.obj,*.min.js
set wildignore+=*/bower_components/*,*/node_modules/*
set wildignore+=*/smarty/*,*/vendor/*,*/.git/*,*/.hg/*,*/.svn/*,*/.sass-cache/*,*/log/*,*/tmp/*,*/build/*,*/ckeditor/*,*/doc/*,*/source_maps/*,*/dist/*
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

" Return to last edit position when opening files (You want this!)
" autocmd BufReadPost *
"      \ if line("'\"") > 0 && line("'\"") <= line("$") |
"      \   exe "normal! g`\"" |
"      \ endif
" Remember info about open buffers on close
" set viminfo^=%



" No annoying sound on errors TODO
"set noerrorbells
"set novisualbell
"set t_vb=
"set tm=500




" Avoid garbled characters in Chinese language windows OS
let $LANG='en'
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim


let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

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

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
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

" Airline.vim {{{
augroup airline_config
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
augroup syntastic_config
  autocmd!
  let g:syntastic_error_symbol = '✗'
  let g:syntastic_warning_symbol = '⚠'
  " let g:syntastic_javascript_checkers = ['eslint']

  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*

  " let g:syntastic_always_populate_loc_list = 1
  " let g:syntastic_auto_loc_list = 1
  " let g:syntastic_check_on_open = 1
  " let g:syntastic_check_on_wq = 0
augroup END
" }}}

filetype plugin indent on

" JSON {{{
augroup filetype_json
  autocmd!
  au BufRead,BufNewFile *.json set ft=json syntax=javascript
augroup END
" }}}

" Markdown {{{
augroup filetype_markdown
  autocmd!
  let g:markdown_fenced_languages = ['ruby', 'html', 'javascript', 'css', 'erb=eruby.html', 'bash=sh']
augroup END
" }}}

