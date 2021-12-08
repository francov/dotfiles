
" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'gmarik/vundle'
Plugin 'kien/ctrlp.vim'
Plugin 'tComment'
Plugin 'mhinz/vim-signify'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree'
Plugin 'PhilRunninger/nerdtree-buffer-ops'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'pangloss/vim-javascript'
Plugin 'maxmellon/vim-jsx-pretty'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'mattn/emmet-vim'
Plugin 'w0rp/ale'
Plugin 'GutenYe/json5.vim'
Plugin 'mhartington/oceanic-next'

call vundle#end()

if (has("termguicolors"))
  set termguicolors
endif

" Switch syntax highlighting on, when the terminal has colors
if &t_Co > 2 || has("gui_running")
  colorscheme OceanicNext
  syntax on
  "set hlsearch
endif

" Save and restore vim session
fu! SaveSess()
  "execute 'call mkdir(~/.vim)'
  execute 'mksession! ~/.vim/session.vim'
endfunction
fu! RestoreSess()
  execute 'so ~/.vim/session.vim'
  highlight clear SignColumn
endfunction
autocmd VimLeave * call SaveSess()
" autocmd VimEnter * call RestoreSess()
:command LS call RestoreSess()

" Don't use Ex mode, use Q for formatting
map Q gq

highlight clear SignColumn
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" change cursor in insert mode
let &t_ti.="\<Esc>[1 q"
let &t_SI.="\<Esc>[5 q"
let &t_EI.="\<Esc>[1 q"
let &t_te.="\<Esc>[0 q"

set t_Co=256
set backspace=indent,eol,start
set backspace=indent,eol,start
set backspace=indent,eol,start
set backspace=indent,eol,start
set backspace=indent,eol,start
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set smartcase " ignore case if search pattern is all lowercase, case-sensitive otherwise

" use mouse (trackpad) scrolling
set mouse=a

" Use space for Tab
set ts=2 sts=2 sw=2 expandtab

" Show line numbers
set number

" Use system clipboard
set clipboard=unnamedplus,unnamed

set nowritebackup
set noswapfile
set nobackup

" Allows buffers to be hidden
set hidden

" Open new split panes to right and bottom, which feels more natural than Vim’s default
set splitbelow
set splitright

" wrap lines
set nowrap linebreak

" Disable the ESC button beep!
set t_vb=
set vb

" use the *real* full-height vertical bar to make solid lines
set fillchars+=vert:│

map gn :bn<CR>
map gp :bp<CR>
map gd :bd<CR>
map gsn :sbn<CR>
map gsp :sbp<CR>
map gsd :sbd<CR>

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Tcomment
nmap <C-c> gcc
vmap <C-c> <C-_>b

set laststatus=2
set timeoutlen=1000 ttimeoutlen=10

" NERDTree
let g:NERDTreeMinimalUI=1
map <C-n> :NERDTreeTabsToggle<CR>

" ale (async linting engine - richiede ambiente node attivo con package prettier installato globale)
let g:ale_linters = {'javascript': ['eslint']}
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0
let g:ale_set_loclist = 1
let g:ale_set_quickfix = 0
let g:ale_open_list = 0
let g:ale_set_balloons = 1
" let g:ale_javascript_eslint_options = '-c .eslintrc.json'
let g:ale_fixers = {'javascript': ['prettier'], 'json': ['prettier'], 'json5': ['prettier'], 'css': ['prettier'], 'less': ['prettier']}
let g:ale_fix_on_save = 1
let g:ale_javascript_prettier_options = '--single-quote --trailing-comma es5 --no-semi --print-width 120 --jsx-bracket-same-line --arrow-parens avoid'
map F :ALEFix<cr>
map E :ALELint<cr>

" ctrlp
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.vagrant/*,*/node_modules/*,*/bower_components/*,*/coverage/*,*/build/*,*/flow-coverage/*,*/flow-typed/*,*/dist/*,*/.next/*
let g:ctrlp_show_hidden = 1

" vim-markdown
let g:vim_markdown_folding_disabled=1

" vim-signify
set updatetime=100

" javascript and jsx
"let g:javascript_plugin_flow = 1
let g:javascript_plugin_flow = 0
let g:javascript_plugin_jsdoc = 1
let g:javascript_enable_domhtmlcss = 1
let g:jsx_ext_required = 0

" emmet
let user_emmet_expandabbr_key = '<c-e>'
let g:user_emmet_settings = {'javascript.jsx': {'extends' : 'jsx' }}

"AIRLINE
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
"let g:airline_detect_whitespace = 0
let g:airline_powerline_fonts = 1
let g:airline_theme = 'minimalist'

" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on

" Makefiles require tab characters.
autocmd FileType make setlocal ts=4 sts=4 sw=4 noexpandtab

" Markdown files with *.md extension
autocmd BufNewFile,BufRead *.md set filetype=markdown

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

augroup END

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

