"" Plugins ===================================================================
" prevent loading vimball
let g:loaded_vimballPlugin=1
let g:loaded_vimball=1

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" plugin list
call plug#begin(expand("~/.config/nvim/bundle"))

  " colorscheme that looks good on terminal
  Plug 'endel/vim-github-colorscheme'

  Plug 'NLKNguyen/papercolor-theme'

  Plug 'zuhdil/vim-alder'


  " full path fuzzy finder (file, buffer, mru, tag, etc)
  Plug 'kien/ctrlp.vim'

  let g:ctrlp_clear_cache_on_exit=0       " keep cache for fast performance
  let g:ctrlp_match_window='max:30'       " longer match window
  let g:ctrlp_open_multiple_files='h'     " open each file in horizontal split
  let g:ctrlp_open_new_file='h'           " open new file in horizontal split
  let g:ctrlp_custom_ignore={
    \ 'dir':  '\v[\/]\.(git|hg|svn|bzr)$',
    \ 'file': '\v\.(exe|so|dll|pyc|swo|swp)$|\v\~$',
    \ }
  let g:ctrlp_user_command={
    \ 'types': {
      \ 1: ['.git', 'cd %s && git ls-files . -co --exclude-standard'],
      \ 2: ['.hg', 'hg --cwd %s locate -I .'],
      \ },
    \ 'fallback': 'find %s -type f'
    \ }
  let g:ctrlp_prompt_mappings = {
    \ 'PrtClearCache()':      ['<F5>', '<c-q>'],
    \ }


  " netrw enhanced
  Plug 'tpope/vim-vinegar'


  " use the power of vim to rename groups of files
  Plug 'vim-scripts/renamer.vim'        , { 'on': 'Renamer' }


  " rename current file
  Plug 'danro/rename.vim'               , { 'on': 'Rename' }


  " session helper
  if has('mksession')
    Plug 'tpope/vim-obsession'

    if has('statusline')
        set statusline=%<%f\ %h%m%r%=%{ObsessionStatus()}\ %-14.(%l,%c%V%)\ %P
    endif


    Plug 'zuhdil/vim-posession'

    let g:posession_dir = '~/.local/share/nvim/session/'

  endif


  " handle extra white spaces
  Plug 'ntpeters/vim-better-whitespace'


  " improves HTML & CSS workflow
  Plug 'mattn/emmet-vim'


  " manage tags files
  Plug 'ludovicchabant/vim-gutentags'

  let g:gutentags_ctags_exclude = ['*.css', '*.html', '*.js', '*.json', '*.xml',
                                  \ '*.phar', '*.ini', '*.rst', '*.md',
                                  \ '*vendor/*/test*', '*vendor/*/Test*',
                                  \ '*vendor/*/fixture*', '*vendor/*/Fixture*',
                                  \ '*var/cache*', '*var/log*', '*compiled.php']
  let g:gutentags_cache_dir = expand("~/.local/share/nvim/tags")


  " php indenting
  Plug '2072/PHP-Indenting-for-VIm'


  " up-to-date php syntax
  Plug 'StanAngeloff/php.vim'

  let php_folding=0
  let php_phpdoc_folding=0


  " improved php omnicompletion
  Plug 'shawncplus/phpcomplete.vim'
  "Plug 'lvht/phpcd.vim', { 'for': 'php', 'do': 'composer install' }


  " automatically insert use statement
  Plug 'arnaud-lb/vim-php-namespace'


  " haskell syntax
  Plug 'neovimhaskell/haskell-vim'


  " scala syntax
  Plug 'derekwyatt/vim-scala'


  " better autocompletion for javascript
  Plug 'marijnh/tern_for_vim'           ,{ 'do': 'npm install' }


  " javascript syntax & indent
  Plug 'pangloss/vim-javascript'


  " vue syntax
  Plug 'posva/vim-vue'


  " elm syntax
  Plug 'ElmCast/elm-vim'


  " jsx syntax
  Plug 'mxw/vim-jsx'


  " html5 omnicomplete and syntax
  Plug 'othree/html5.vim'
  Plug 'othree/html5-syntax.vim'


  " css syntax
  Plug 'JulesWang/css.vim'
  Plug 'hail2u/vim-css3-syntax'


  " highlight colors in css files
  Plug 'ap/vim-css-color'


  " scss syntax
  Plug 'cakebaker/scss-syntax.vim'


  " less syntax
  Plug 'groenewege/vim-less'


  " twig syntax
  Plug 'evidens/vim-twig'


  " blade syntax
  Plug 'jwalton512/vim-blade'


  " Github flavored markdown
  Plug 'gabrielelana/vim-markdown'

  let g:markdown_include_jekyll_support = 0
  let g:markdown_enable_spell_checking = 0


call plug#end()

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif


"" themes ====================================================================
colorscheme PaperColor


"" General config ============================================================
if has('autocmd')
  filetype plugin indent on " load file type plugins + indentation
endif
if has('syntax')
  syntax enable             " enable syntax highlighting
endif
set hidden                  " allow buffer switching without saving
set autoread                " automatically reload file changed from outside


"" User interface ============================================================
set number                  " show line numbers
set laststatus=2            " always show status line
set showmode                " display the current mode
set splitbelow              " more natural split opening
set splitright
if has('cmdline_info')
  set showcmd               " display incomplete commands
  set ruler                 " cursor position
endif
if !&scrolloff
  set scrolloff=1           " keep a line above or below the cursor when scrolling
endif
if !&sidescrolloff
  set sidescrolloff=5       " keep 5 columns next to the cursor when scrolling horizontally
endif
if has('linebreak')
    set linebreak           " if wrap is on, wrap line at a word boundary
    set breakat=\ \	_,;*+\\/?!  " a somewhat code friendly line wrap break char
    set showbreak=↳…        " symbol for the wrapped lines
    set breakindent         " indent wrapped lines
endif
set list                    " show hidden character and highlight problematic whitespace
set listchars=tab:┊·,trail:×,extends:…,precedes:…,nbsp:∙


"" Editing ===================================================================
if has('virtualedit')
  set virtualedit=all       " allow for cursor beyond last character
endif
set textwidth=0             " prevent automatic wraping of inserted text
set cpoptions+=$            " put $ at the end of changed text instead of just deleting

" indentation
set tabstop=4               " tab column is 4 spaces
set shiftwidth=4            " use indent of 4 spaces
set softtabstop=4           " let backspace delete indent
set expandtab               " indent use spaces, not tabs

" override indentation for filetypes
autocmd Filetype vim        setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype css        setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype less       setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype html       setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype html.twig  setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType blade      setlocal ts=2 sts=2 sw=2 expandtab


"" Miscellaneous ==================================================================
set ignorecase              " searches are case insensitive...
set smartcase               " ... unless they contain at least one capital letter

set wildmode=list:longest   " command completion, list matches and complete till logest common part

set nobackup                " just cluttering working dir, we should use VCS anyway
if &history < 1000
  set history=1000          " store a ton of history
endif
if has('persistent_undo')
  set undofile              " persist undo history
  set undolevels=1000       " maximum number of changes that can be undone
  set undoreload=10000      " maximum number lines to save for undo on a buffer reload
endif
if has('mksession')
  set sessionoptions+=resize                " save windows state
  autocmd BufWinLeave *.* silent! mkview    " save view on buffer removed from window
  autocmd BufWinEnter *.* silent! loadview  " load view on buffer displayed in a window
endif

autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP


"" arnaud-lb/vim-php-namespace ================================================
let g:php_namespace_sort_after_insert = 1

autocmd FileType php inoremap <Leader>s <Esc>:call PhpSortUse()<CR>
autocmd FileType php noremap <Leader>s :call PhpSortUse()<CR>

function! IPhpInsertUse()
  call PhpInsertUse()
  call feedkeys('a',  'n')
endfunction
autocmd FileType php inoremap <Leader>u <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <Leader>u :call PhpInsertUse()<CR>

function! IPhpExpandClass()
  call PhpExpandClass()
  call feedkeys('a', 'n')
endfunction
autocmd FileType php inoremap <Leader>e <Esc>:call IPhpExpandClass()<CR>
autocmd FileType php noremap <Leader>e :call PhpExpandClass()<CR>
