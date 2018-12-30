" Plugins: {{{1
" Plugin register {{{2
function! PackInit() abort
  packadd minpac
  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  " Additional plugins here. {{{3
  call minpac#add('ntpeters/vim-better-whitespace')
  call minpac#add('w0rp/ale')
  call minpac#add('leafgarland/typescript-vim')
  call minpac#add('neoclide/jsonc.vim')

  call minpac#add('NLKNguyen/papercolor-theme', {'type': 'opt'})
  call minpac#add('qpkorr/vim-renamer', {'type': 'opt'})
  call minpac#add('mattn/emmet-vim', {'type': 'opt'})
  call minpac#add('pangloss/vim-javascript', {'type': 'opt'})
  call minpac#add('maxmellon/vim-jsx-pretty', {'type': 'opt'})

  if has('nvim')
    call minpac#add('neoclide/coc.nvim', {'type': 'opt', 'do': {-> coc#util#install()}})
    call minpac#add('Shougo/denite.nvim', {'type': 'opt'})
  endif
endfunction

" Plugin settings here. {{{2
if has('autocmd')
  augroup ondemand_plugins
    " release all autocomands in these group
    autocmd!

    " by file types
    autocmd FileType javascript packadd vim-javascript
    autocmd FileType javascript,typescript packadd vim-jsx-pretty
    autocmd FileType html,css,javascript,typecheck packadd emmet-vim

    " by command calls
    autocmd CmdUndefined Renamer packadd vim-renamer

    if has('nvim')
      autocmd FileType javascript,typescript,json,jsonc packadd coc.nvim
      autocmd CmdUndefined Denite* packadd denite.nvim
    endif
  augroup END
endif

" ALE config
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_save = 1 " default
let g:ale_lint_on_enter = 0
let g:ale_lint_on_filetype_changed = 0

" vim-javascript
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_flow = 1

" vim-renamer
" apply file renaming with :w
let g:RenamerSupportColonWToRename = 1

" emmet
let g:user_emmet_settings = {
      \  'javascript' : {
      \     'extends' : 'jsx',
      \  },
      \  'typescript' : {
      \     'extends' : 'jsx',
      \  },
      \}


" User commands for updating/cleaning the plugins. {{{2
function! PostPackUpdate()
  if has('nvim') | UpdateRemotePlugins | endif
  call minpac#status()
endfunction
command! PackUpdate call PackInit() | call minpac#update('', {'do': 'call PostPackUpdate()'})
command! PackClean  call PackInit() | call minpac#clean()
command! PackStatus call PackInit() | call minpac#status()

" Install minpac if not already installed {{{2
if executable('git') && globpath(split(&rtp, ',')[0], 'pack/minpac') == ''
  echo 'Install minpac ...'
  execute 'silent !git clone https://github.com/k-takata/minpac.git ' . split(&packpath, ',')[0] . '/pack/minpac/opt/minpac'
  call PackInit() | call minpac#update('', {'do': 'source $MYVIMRC'})
endif



" Editor: {{{1
if has('syntax')
  " enable syntax highlighting
  syntax enable
endif

colorscheme PaperColor

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
endif

" vim:fdm=marker expandtab fdc=3 ft=vim ts=2 sw=2 sts=2:
