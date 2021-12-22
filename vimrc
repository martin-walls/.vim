" vim:foldmethod=marker

" set <leader> to <space>
let mapleader=" "

" ┌────────────────┐
" │ Basic settings │
" └────────────────┘
" {{{
set nocompatible

" Tabs/spaces
set tabstop=2
set shiftwidth=2
set softtabstop=2
" turn tabs into spaces
set expandtab
set autoindent

" show line numbers
set number

" make splits natural
set splitright
set splitbelow

" vertical window separator between splits
set fillchars+=vert:┃

" show whitespace: tabs, trailing spaces
set list
set listchars=tab:»-,trail:·

" tab completion
set wildmode=longest,list,full

" don't wrap in middle of word
set linebreak

" mouse support
set mouse=a
set ttymouse=sgr
set ttyfast

" Code folding
" save code folds between sessions
" autocmd BufWinLeave *.* mkview
" autocmd BufWinEnter *.* silent loadview
set foldmethod=manual
" show folds left of line numbers; can be opened/closed w/ mouse
set foldcolumn=2
" fold: chars at end of line on closed fold
" foldopen, foldsep: foldcolumn chars
set fillchars+=fold:\ ,foldopen:┍,foldsep:│
" minimum number of lines for FastFold to be enabled
let g:fastfold_minlines=0

" Change cursor shape in different modes (Terminus)
let g:TerminusCursorShape = 1
" disable Terminus trying to improve mouse function
let g:TerminusMouse = 0

" }}}

" ┌────────┐
" │ Colors │
" └────────┘
" {{{
" 24-bit colour support
set termguicolors
syntax on
let g:onedark_hide_endofbuffer=1
let g:onedark_terminal_italics=1
colorscheme onedark

" remove background, to respect terminal transparency
hi Normal ctermbg=NONE guibg=NONE

" }}}

" ┌──────────┐
" │ Mappings │
" └──────────┘
" {{{
" find and replace all occurrences of word under cursor
nnoremap <F6> :%s/\<<C-r><C-w>\>//g<Left><Left>
" general find and replace shortcut
nnoremap S :%s//g<Left><Left>

" add undo action per word
inoremap <Space> <Space><C-g>u
inoremap <c-w> <c-g>u<c-w>
inoremap <c-u> <c-g>u<c-u>

" add brackets around visual selection
vnoremap { xi{}<Esc>P
vnoremap ( xi()<Esc>P
vnoremap [ xi[]<Esc>P

" --commentary--
" ctrl-/
nmap <c-_> gcc
imap <c-_> <c-o>gcc
vmap <c-_> gc
" alternate comment shortcut for normal/fold modes
nmap <leader>c gcc
vmap <leader>c gc

" --bufferlist--
map <silent> <F3> :call BufferList()<CR>

" }}}

" ┌──────────┐
" │ Movement │
" └──────────┘
" {{{
" move up/down one line as it appears on screen
noremap <Up> gk
noremap <Down> gj
inoremap <Up> <c-o>gk
inoremap <Down> <c-o>gj
" home/end for line as it appears on screen
set <Home>=OH
set <End>=OF
noremap <Home> g^
noremap <End> g$
inoremap <Home> <c-o>g^
inoremap <End> <c-o>g$

" Window navigation shortcuts
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
nnoremap <c-h> <c-w>h

" Move lines up/down (and reindent to match new pos)
set <A-j>=j
set <A-k>=k
nnoremap <A-j> :m.+1<CR>==
nnoremap <A-k> :m.-2<CR>==
inoremap <A-j> <Esc>:m.+1<CR>==gi
inoremap <A-k> <Esc>:m.-2<CR>==gi
vnoremap <A-j> :m'>+1<CR>gv=gv
vnoremap <A-k> :m'<-2<CR>gv=gv
" also allow using arrow keys
map <A-Down> <A-j>
map <A-Up> <A-k>

" }}}

" ┌──────────────────┐
" │ General AutoCmds │
" └──────────────────┘
" {{{
augroup GeneralAutocmd
  au!
  " automatically center screen in insert mode
  au InsertEnter * norm zz
  " strip trailing spaces on save
  au BufWritePre * %s/\s\+$//e
augroup END

" }}}

" ┌───────┐
" │ LaTeX │
" └───────┘
" {{{
let g:tex_flavor='latex'
set conceallevel=1
" a = accents/ligatures
" b = bold & italic
" d = delimiters
" g = greek
" other opts:
"   m = math symbols
"   s = superscripts/subscripts
let g:tex_conceal='abdg'
" disable unreadable conceals
let g:vimtex_syntax_conceal = {
      \ 'math_fracs': 0,
      \ 'math_super_sub': 0
      \ }
" Use XeLaTeX
let g:vimtex_compiler_latexmk_engines = {
      \ '_' : '-xelatex'
      \ }

" tex folding
let g:vimtex_fold_types = {
      \ 'envs': {
        \   'blacklist': ['enumerate', 'itemize', 'lstlisting'],
        \   'whitelist': ['examquestion'],
        \ },
        \ }

" auto compile and clean
augroup vimtex_auto_compile_clean
  au!
  au User VimtexEventQuit VimtexClean
  " au User VimtexEventInitPost VimtexCompile
augroup END

" }}}

" ┌──────────────────┐
" │ Explorer (Netrw) │
" └──────────────────┘
" {{{
let g:netrw_dirhistmax=0
" hide top banner
let g:netrw_banner = 0
" open files in new vertical split
let g:netrw_browse_split = 2
" set % width
let g:netrw_winsize = 25

" }}}

" ┌──────────────────────┐
" │ Snippets (UltiSnips) │
" └──────────────────────┘
" {{{
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsEditSplit = 'context'
" }}}

" ┌─────────────────────────────────────────────┐
" │ Autocompletion (MUComplete, Clang Complete) │
" └─────────────────────────────────────────────┘
" {{{
" --MUComplete--
let g:mucomplete#chains = {
  \ 'default' : ['path', 'omni', 'keyn', 'dict'],
  \ 'vim'     : ['path', 'cmd', 'keyn'],
  \ 'tex'     : ['ulti', 'path', 'omni', 'keyn', 'dict']
  \ }
" \ 'tex'     : ['ulti', 'path', 'omni', 'keyn', 'dict', 'uspl']
" if no results from autocompletion, insert a literal tab
let g:mucomplete#tab_when_no_results = 1
set completeopt+=menuone,noselect
set shortmess+=c
set noinfercase
let g:mucomplete#enable_auto_at_startup = 1
" CapsLock mapped to <F2> for completion
imap <f2> <plug>(MUcompleteFwd)
imap <s-f2> <plug>(MUcompleteBwd)
" when popup menu visible, enter selects highlighted item
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" --clang complete--
let g:clang_library_path = '/usr/lib/llvm-10/lib'
let g:clang_complete_auto = 1
let g:clang_close_preview = 1

" }}}

" ┌──────────────────────────────┐
" │ Bracket Matching (Pear Tree) │
" └──────────────────────────────┘
" {{{
" custom pairs to auto close
let g:pear_tree_pairs = {
  \ '(': {'closer': ')'},
  \ '[': {'closer': ']'},
  \ '{': {'closer': '}'},
  \ "'": {'closer': "'"},
  \ '"': {'closer': '"'},
  \ '/\*': {'closer': '\*/'},
  \ '<!--': {'closer': '-->'}
  \ }
"let g:pear_tree_repeatable_expand = 0

" smart pairs
let g:pear_tree_smart_openers = 1
let g:pear_tree_smart_closers = 1
let g:pear_tree_smart_backspace = 1
let g:pear_tree_repeatable_expand = 0

" }}}

" ┌───────────┐
" │ Lightline │
" └───────────┘
" {{{
" make lightline show
set laststatus=2
" disable default -- INSERT -- etc
set noshowmode
" lightline config
let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'readonly', 'filename', 'modified' ] ],
  \   'right': [ [], [ 'percent', 'lineinfo' ], [ 'filetype' ] ]
  \ },
  \ 'inactive': {
  \   'left': [[ 'filename', 'modified' ]]
  \ },
  \ 'component_function': {
  \   'gitbranch': 'FugitiveHead',
  \   'lineinfo': 'LightlineLineInfo',
  \   'percent': 'LightlinePercent',
  \   'filetype': 'LightlineFiletype',
  \   'mode': 'LightlineMode'
  \ },
  \ }

function! LightlineLineInfo() abort
  if winwidth(0) < 75
    return ''
  endif

  let l:current_line = printf('%-3s', line('.'))
  let l:max_line = printf('%-3s', line('$'))
  let l:lineinfo = l:current_line . '/' . l:max_line
  return l:lineinfo
endfunction

function! LightlinePercent() abort
  if winwidth(0) < 55
    return ''
  endif

  let l:percent = line('.') * 100 / line('$') . '%'
  return printf('%-4s', l:percent)
endfunction

function! LightlineFiletype() abort
  if winwidth(0) < 55
    return ''
  endif

  return &filetype
endfunction

function! LightlineMode() abort
  let ftmap = {
        \ 'netrw': 'EXPLORER'
        \ }
  return get(ftmap, &filetype, lightline#mode())
endfunction

" }}}

" ┌────────────┐
" │ Spellcheck │
" └────────────┘
" {{{
set spelllang=en
"au FileType tex setlocal noautoindent
"au FileType tex setlocal nocindent
"au FileType tex setlocal indentexpr=

" snippets file syntax highlighting
" au BufNewFile,BufRead *.snippets set ft=snippets
" au FileType snippets setlocal syntax=snippets

" }}}

" ┌───────────────────┐
" │ Filetype AutoCmds │
" └───────────────────┘
" {{{
" Snippets
augroup filetype_autocmds
  au!
  au BufNewFile,BufRead *.snippets set filetype=snippets
augroup END
" }}}

" ┌──────┐
" │ Goyo │
" └──────┘
" {{{
let g:goyo_width = '120'
let g:goyo_height = '100%'
autocmd! User GoyoEnter nested call lightline#enable()
" }}}

" ┌────────────────┐
" │ File templates │
" └────────────────┘
" {{{
" supo work template
augroup file_templates
  au!
  " Supo work template and preamble
  au BufNewFile mrw64*.tex 0r ~/.vim/templates/supotemplate.tex
  au BufNewFile preamble.tex 0r ~/.vim/templates/supopreamble.tex
augroup END
" }}}

" ┌───────────────────────┐
" │ WSL Specific Settings │
" └───────────────────────┘
" {{{
let uname = substitute(system('uname'),'\n','','')
if uname == 'Linux'
  let lines = readfile("/proc/version")
  if lines[0] =~ "Microsoft"
    " in WSL

    " WSL clipboard support
    let s:clip = '/mnt/c/Windows/System32/clip.exe'
    if executable(s:clip)
      augroup WslYank
        au!
        au TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
      augroup END
    endif

  endif
endif
" }}}

" ┌─────────────────────────┐
" │ Start Screen (Startify) │
" └─────────────────────────┘
" {{{
let g:startify_bookmarks = [
  \ {'c': '~/.vimrc'},
  \ {'g': '~/.gvimrc'},
  \ {'u': '~/UNI/supo-work-template/template/mrw_preamble.tex'}
  \ ]
let g:startify_session_autoload = 1
" }}}

" ┌───────────────────────────┐
" │ Inbuilt Terminal Settings │
" └───────────────────────────┘
" {{{
augroup TerminalConfig
  au!
  au TerminalOpen * setlocal nonumber foldcolumn=0
augroup END

" go into normal mode in terminal
if exists(':tnoremap')
  tnoremap <Esc><Esc> <c-\><c-n>
endif

" open terminal in vertical split
command Vter vert ter
" }}}
