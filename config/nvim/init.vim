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

  call packager#add('neoclide/coc.nvim', {'branch': 'release'})

  call packager#add('pangloss/vim-javascript')
  call packager#add('leafgarland/typescript-vim')
  call packager#add('peitalin/vim-jsx-typescript')
  call packager#add('ekalinin/Dockerfile.vim')

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

" CtrlP config {{{2
" Use fd in CtrlP for listing files, very fast and respects .gitignore.
let g:ctrlp_user_command = 'fd --type f --hidden --exclude ".git" --color=never "" %s'
" Using fd is fast, we don't need to cache.
let g:ctrlp_use_caching = 0
" Custom marker for when working with large monorepo project
let g:ctrlp_root_markers = ['.ctrlp']

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

" python provider config
let g:python3_host_prog = '~/.pyenv/versions/neovim/bin/python'



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



" coc.nvim config {{{1
let g:coc_global_extensions = [
  \ 'coc-json',
  \ 'coc-python',
  \ 'coc-tsserver',
  \ 'coc-prettier',
  \ ]

" TextEdit might fail if hidden is not set.
" set hidden

" Some servers have issues with backup files, see #649.
" set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" " Use CTRL-S for selections ranges.
" " Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
" nmap <silent> <C-s> <Plug>(coc-range-select)
" xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add `:Prettier` command to run prettier
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set statusline^=%{coc#status()}\ 

" " Mappings for CoCList
" " Show all diagnostics.
" nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" " Manage extensions.
" nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" " Show commands.
" nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" " Find symbol of current document.
" nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" " Search workspace symbols.
" nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list.
" nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
