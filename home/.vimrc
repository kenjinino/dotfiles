set nocompatible              " be iMproved, required
filetype off                  " required

call plug#begin('~/.vim/plugged')
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" Look and feel {{{
  Plug 'itchyny/lightline.vim'
  Plug 'flazz/vim-colorschemes'
" }}}

" Search {{{
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
  Plug 'rking/ag.vim'
" }}}

" Completions and Snippets {{{
  Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
  Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
  Plug 'jiangmiao/auto-pairs'
" }}}

" General Programming {{{
  Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
  Plug 'tpope/vim-fugitive'
  Plug 'sjl/gundo.vim'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'tpope/vim-unimpaired'
  Plug 'w0rp/ale'
" }}}

" Language Specific {{{
  " Rails
  Plug 'tpope/vim-rails'
" }}}

" Syntax Highlighting {{{
  " Pug
  Plug 'digitaltoad/vim-pug'

  " Stylus
  Plug 'wavded/vim-stylus'

  " Less
  Plug 'groenewege/vim-less'

  " Typescript
  Plug 'HerringtonDarkholme/yats.vim'
" }}}

" All of your Plugins must be added before the following line
call plug#end()
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2   " Configure tabs to two spaces
set shiftround      " Configure tabs to two spaces

set laststatus=2

map <F2> :NERDTreeToggle<CR>

map <C-p> :FZF<CR>

if !has('gui_running')
  set t_Co=256
endif

colorscheme Tomorrow-Night

"""""""""""""
" FZF
"""""""""""""

let $FZF_DEFAULT_COMMAND = 'ag -g ""'

"""""""""""""
" Vim options
"""""""""""""
set number          " Show line numbers

"" Persistent Undo [Begin]
set undolevels=1000      " use many muchos levels of undo
set undofile
set undodir=$HOME/.vim/undo
set undolevels=1000
set undoreload=10000
" Put plugins and dictionaries in this dir (also on Windows)
let vimDir = '$HOME/.vim'
let &runtimepath.=','.vimDir

" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
  let myUndoDir = expand(vimDir . '/undodir')
  " Create dirs
  call system('mkdir ' . vimDir)
  call system('mkdir ' . myUndoDir)
  let &undodir = myUndoDir
  set undofile
endif
"" Persistent Undo [End]

"" Source the vimrc file after saving it [Begin]
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif
"" Source the vimrc file after saving it [End]

"Allow usage of mouse in iTerm
"set ttyfast
"set mouse=a
"set ttymouse=xterm2

""""""""""""""""""""
" Tmux compatibility
""""""""""""""""""""
" Quicker window movement
"nnoremap <esc>j <C-w>j
"nnoremap <esc>k <C-w>k
"nnoremap <esc>h <C-w>h
"nnoremap <esc>l <C-w>l


""""""""""""""""""""
" Copy to clipboard
""""""""""""""""""""
set clipboard=unnamedplus

" resize panes
nnoremap <silent> <Right> :vertical resize +5<cr>
nnoremap <silent> <Left> :vertical resize -5<cr>
nnoremap <silent> <Up> :resize +5<cr>
nnoremap <silent> <Down> :resize -5<cr>

" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

""""""""""""""""""""""""""""
" Move lines around
""""""""""""""""""""""""""""
" Bubble single lines
nmap <C-k> [e
nmap <C-j> ]e
" Bubble multiple lines
vmap <C-k> [egv
vmap <C-j> ]egv

""""""""""""""""""""""""""""
" Ultisnips
""""""""""""""""""""""""""""
" Trigger configuration
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

"""""""
" CtrlP
"""""""

" if exists("g:ctrlp_user_command")
"   unlet g:ctrlp_user_command
" endif
"
" if executable('ag')
"   " Use ag over grep
"   set grepprg=ag\ --nogroup\ --nocolor\ --smart-case
"
"   " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
"   let g:ctrlp_user_command =
"     \ 'ag %s --files-with-matches -g "" --ignore "\.git$\|\.hg$\|\.svn$" --ignore "*.log"'
"
"   " ag is fast enough that CtrlP doesn't need to cache
"   let g:ctrlp_use_caching = 0
" else
"   " Fall back to using git ls-files if Ag is not available
"   let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
"   let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']
" endif

""""""""""""""""""""""""""""
" Ag
""""""""""""""""""""""""""""
" Running Ag with smart case 'Match case insensitively unless PATTERN contains uppercase characters'
let g:AgSmartCase = 1
let g:ag_working_path_mode="r"

""""""""""""""""""""""""""""
" ejs files highlighting
""""""""""""""""""""""""""""
au BufNewFile,BufRead *.ejs set filetype=html

""""""""""""""""""""""
" Custom configuration
""""""""""""""""""""""
augroup BeforeExit
  autocmd!
  autocmd BufWritePre * :%s/\s\+$//e "Automatically removes all trailing whitespace
augroup end

let g:lightline = {
      \ 'colorscheme': 'Tomorrow_Night',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], ['ctrlpmark'] ],
      \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightLineFugitive',
      \   'filename': 'LightLineFilename',
      \   'fileformat': 'LightLineFileformat',
      \   'filetype': 'LightLineFiletype',
      \   'fileencoding': 'LightLineFileencoding',
      \   'mode': 'LightLineMode',
      \   'ctrlpmark': 'CtrlPMark',
      \ },
      \ 'component_expand': {
      \   'syntastic': 'SyntasticStatuslineFlag',
      \ },
      \ 'component_type': {
      \   'syntastic': 'error',
      \ },
      \ }

function! LightLineModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
  return &ft !~? 'help' && &readonly ? "\ue0a2" : ''
endfunction

function! LightLineFilename()
  let fname = expand('%')
  return fname == 'ControlP' ? g:lightline.ctrlp_item :
        \ fname == '__Tagbar__' ? g:lightline.fname :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
  try
    if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
      let mark = "\ue0a0 "  " edit here for cool mark
      let _ = fugitive#head()
      return strlen(_) ? mark._ : ''
    endif
  catch
  endtry
  return ''
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! CtrlPMark()
  if expand('%:t') =~ 'ControlP'
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction

let g:ctrlp_status_func = {
  \ 'main': 'CtrlPStatusFunc_1',
  \ 'prog': 'CtrlPStatusFunc_2',
  \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction

augroup AutoSyntastic
  autocmd!
  autocmd BufWritePost *.c,*.cpp call s:syntastic()
augroup END
function! s:syntastic()
  SyntasticCheck
  call lightline#update()
endfunction


""""""""""""""""""""""""""""
" ale linter
""""""""""""""""""""""""""""
let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0

let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_lint_on_save = 1
let g:ale_javascript_eslint_use_global = 0

