" Packager: {{{1
if &compatible
  set nocompatible
endif

" Load packager only when you need it {{{2
function! PackagerInit() abort
  packadd vim-packager
  call packager#init()
  call packager#add('kristijanhusak/vim-packager', { 'type': 'opt' })

  " Register additional plugins here. {{{3
  call packager#add('tpope/vim-eunuch')
  call packager#add('kien/ctrlp.vim')

  call packager#add('lifepillar/vim-gruvbox8', {'type': 'opt'})
  call packager#add('qpkorr/vim-renamer', {'type': 'opt'})
endfunction

" Plugin settings here. {{{2
if has('autocmd')
  augroup ondemand_plugins
    " release all autocomands in these group
    autocmd!

    " by command calls
    autocmd CmdUndefined Renamer packadd vim-renamer
  augroup END
endif

" CtrlP config
" Use fd in CtrlP for listing files, very fast and respects .gitignore.
let g:ctrlp_user_command = 'fd --type f --hidden --exclude ".git" --color=never "" %s'
" Using fd is fast, we don't need to cache.
let g:ctrlp_use_caching = 0

" User commands for managing plugins. {{{2
command! PackagerInstall call PackagerInit() | call packager#install()
command! -bang PackagerUpdate call PackagerInit() | call packager#update({ 'force_hooks': '<bang>'})
command! PackagerClean call PackagerInit() | call packager#clean()
command! PackagerStatus call PackagerInit() | call packager#status()

" Install vim-packager if not already installed {{{2
if executable('git') && globpath(split(&rtp, ',')[0], 'pack/packager') == ''
  echo 'Install vim-packager ...'
  execute 'silent !git clone https://github.com/kristijanhusak/vim-packager ' . split(&packpath, ',')[0] . '/pack/packager/opt/vim-packager'
  :PackagerInstall
endif



" Editor: {{{1
if has('syntax')
  " enable syntax highlighting
  syntax enable
endif

set background=dark
colorscheme gruvbox8_hard

" show line numbers
set number
" show hidden character and highlight problematic whitespace
set list
set listchars=tab:┊·,trail:×,extends:…,precedes:…,nbsp:∙

" Status line {{{2
" always show status line
set laststatus=2
" command completion, list matches and complete till logest common part
set wildmode=list:longest
if has('cmdline_info')
  " display incomplete commands
  set showcmd
  " cursor position
  set ruler
endif

" Cursor {{{2
" allow for cursor beyond last character
if has('virtualedit') | set virtualedit=all | endif
" keep 5 columns next to the cursor when scrolling horizontally
if !&sidescrolloff | set sidescrolloff=5 | endif
" keep a line above or below the cursor when scrolling
if !&scrolloff | set scrolloff=1 | endif
" put $ at the end of changed text instead of just deleting
set cpoptions+=$

" Indentation {{{2
" tab column is 2 spaces
set tabstop=2
" let backspace delete indent
set softtabstop=2
" use indent of 2 spaces
set shiftwidth=2
" indent use spaces, not tabs
set expandtab

" Text wrapping {{{2
" prevent automatic wraping of inserted text
set textwidth=0
if has('linebreak')
  " if wrap is on, wrap line at a word boundary
  set linebreak
  " a somewhat code friendly line wrap break char
  set breakat=\ \	_,;*+\\/?!
  " symbol for the wrapped lines
  set showbreak=↳…
  " indent wrapped lines
  set breakindent
endif

" Searching {{{2
" searches are case insensitive...
set ignorecase
" ... unless they contain at least one capital letter
set smartcase



" History And Backup: {{{1
" just cluttering working dir, we should use VCS anyway
set nobackup
" store a ton of history
if &history < 1000 | set history=1000 | endif
" persist undo history
if has('persistent_undo')
  set undofile
  " maximum number of changes that can be undone
  set undolevels=1000
  " maximum number lines to save for undo on a buffer reload
  set undoreload=10000
  " set undo files directory for vim
  if !has('nvim') | set undodir=~/.vim/undo | endif
endif



" Window Buffer: {{{1
" detect changes from outside
set autoread
" allow buffer switching without saving
set hidden
" more natural split opening
set splitbelow
set splitright



" Autocmd: {{{1
if has('autocmd')
  " load file type plugins + indentation
  filetype plugin indent on

  augroup vimrc
    " release all autocomands in these group
    autocmd!

    if has('persistent_undo')
      " disable persistent undo for temporary file,
      " rel 'set undofile'
      autocmd BufWritePre /tmp/* setlocal noundofile
    endif
    " check file change every 4 seconds ('CursorHold') and reload the buffer upon detecting change,
    " rel 'set autoread'
    autocmd CursorHold * checktime
    " overwrite tsconfig file type
    autocmd BufNewFile,BufRead tsconfig.json setlocal filetype=jsonc
  augroup END

  augroup filetypeoverrides
    autocmd FileType php setlocal ts=4 sts=4 sw=4 et
  augroup END
endif

" vim:fdm=marker expandtab fdc=3 ft=vim ts=2 sw=2 sts=2:
