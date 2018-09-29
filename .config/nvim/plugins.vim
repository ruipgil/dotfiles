" Neobundle {{{
set nocompatible
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

let g:python_host_prog="/usr/local/bin/python3"

call neobundle#begin(expand('~/.vim/bundle'))

NeoBundleFetch 'Shougo/neobundle.vim' " Neobundle manages Neobundle
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'

" General
NeoBundle 'chaoren/vim-wordmotion'
" More targets
" + ci$ to change inside $
" + cia to change inside argument
" can be used with numeration
NeoBundle 'wellle/targets.vim'
" Comment easily: gc[c|{n}{direction}]
NeoBundle 'tpope/vim-commentary'
" Expand or contract arguments (e.g. JSON, function parameters)
" <leader>a
NeoBundle 'FooSoft/vim-argwrap'

" File navigation
NeoBundle 'scrooloose/nerdtree'

" Colors, and and shapes
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'taohex/lightline-buffer'
NeoBundle 'editorconfig/editorconfig-vim'
NeoBundle 'edkolev/tmuxline.vim'
NeoBundle 'christoomey/vim-tmux-navigator'
NeoBundle 'Yggdroot/indentLine'

" NeoBundle 'junegunn/goyo.vim'

" Evaluating
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-surround'
NeoBundle 'kballard/vim-swift', { 'filetypes': 'swift', 'unite_sources': ['swift/device', 'swift/developer_dir'] }
"
NeoBundle 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
NeoBundle 'junegunn/fzf.vim'

NeoBundle 'rbgrouleff/bclose.vim'

NeoBundle 'w0rp/ale'
NeoBundle 'maximbaz/lightline-ale'

" 100+ filetype support
NeoBundle 'sheerun/vim-polyglot'
" Better support for repeat
NeoBundle 'tpope/vim-repeat'
" Detects tabs/spaces. Finally!
NeoBundle 'tpope/vim-sleuth'

" TAB for completions
NeoBundle 'ervandew/supertab'
" Better start window
NeoBundle 'mhinz/vim-startify'
" Move around like a pro
NeoBundle 'easymotion/vim-easymotion'

NeoBundle 'prabirshrestha/async.vim'
NeoBundle 'prabirshrestha/vim-lsp'

autocmd FileType typescript setlocal omnifunc=lsp#complete

NeoBundle 'prabirshrestha/asyncomplete.vim'
NeoBundle 'prabirshrestha/asyncomplete-lsp.vim'

call neobundle#end()

NeoBundleCheck " auto install
" }}}
