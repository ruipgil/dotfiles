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
" NeoBundle 'scrooloose/nerdcommenter'
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
" NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'scrooloose/nerdtree'
" NeoBundle 'qpkorr/vim-bufkill'

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
" NeoBundle 'Shougo/deoplete.nvim'
" NeoBundle 'zchee/deoplete-jedi'
" NeoBundle 'python-mode/python-mode'
" let g:deoplete#enable_at_startup = 1
NeoBundle 'majutsushi/tagbar'
" NeoBundle 'elzr/vim-json'
" NeoBundle 'christoomey/vim-sort-motion'
" NeoBundle 'neomake/neomake'
" NeoBundle 'dojoteef/neomake-autolint'
NeoBundle 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
NeoBundle 'junegunn/fzf.vim'
" NeoBundle 'Yggdroot/indentLine'

NeoBundle 'mindriot101/vim-yapf'
NeoBundle 'fatih/vim-go'
NeoBundle 'rbgrouleff/bclose.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'alfredodeza/coveragepy.vim'

NeoBundle 'posva/vim-vue'
NeoBundle 'w0rp/ale'

" 100+ filetype support
NeoBundle 'sheerun/vim-polyglot'
" Better support for repeat
NeoBundle 'tpope/vim-repeat'
" Detects tabs/spaces. Finally!
NeoBundle 'tpope/vim-sleuth'

NeoBundle 'neowit/vim-force.com'

call neobundle#end()

NeoBundleCheck " auto install
" }}}
