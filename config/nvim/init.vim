"" Plugins ===================================================================
" prevent loading vimball
let g:loaded_vimballPlugin=1
let g:loaded_vimball=1

" automatically install vim-plug
let s:has_bundle=1
if !filereadable(expand("~/.config/nvim/autoload/plug.vim"))
  echo "Installing vim-plug..."
  echo ""
  silent call mkdir(expand("~/.config/nvim/autoload"), 'p')
  silent exe '!curl -fLo '.expand("~/.config/nvim/autoload/plug.vim").' https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  let s:has_bundle=0
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


  " netrw enhanced
  Plug 'tpope/vim-vinegar'


  " use the power of vim to rename groups of files
  Plug 'vim-scripts/renamer.vim'        , { 'on': 'Renamer' }


  " rename current file
  Plug 'danro/rename.vim'               , { 'on': 'Rename' }


  " easy session manager
  if has('mksession')
    Plug 'vim-scripts/sessionman.vim'   , { 'on': ['SessionList', 'SessionOpenLast', 'SessionSaveAs'] }
  endif


  " handle extra white spaces
  Plug 'ntpeters/vim-better-whitespace'


  " improves HTML & CSS workflow
  Plug 'mattn/emmet-vim'


  " manage tags files
  Plug 'ludovicchabant/vim-gutentags'

  let g:gutentags_exclude = ['*.css', '*.html', '*.js', '*compiled.php']
  let g:gutentags_cache_dir = expand("~/.local/share/nvim/tags")


  " up-to-date php syntax
  Plug 'StanAngeloff/php.vim'

  let php_folding=0
  let php_phpdoc_folding=0


  " improved php omnicompletion
  Plug 'shawncplus/phpcomplete.vim'


  " better autocompletion for javascript
  Plug 'marijnh/tern_for_vim'           ,{ 'do': 'npm install' }

  "let g:tern#command = ["nodejs", expand('<sfile>:h') . '/bundle/tern_for_vim/node_modules/tern/bin/tern', '--no-port-file']


  " javascript syntax & indent
  Plug 'pangloss/vim-javascript'


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

" installing plugins for the first time
if s:has_bundle == 0 || !isdirectory(expand("~/.config/nvim/bundle"))
  echo "Installing Plugins..."
  echo ""
  :PlugInstall
endif

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
