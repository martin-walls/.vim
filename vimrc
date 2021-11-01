" use 2 spaces for tab
set tabstop=2
set shiftwidth=2
" turn tabs into spaces
set expandtab
" show line numbers
set number
set autoindent
set nocompatible

set splitright
set splitbelow

" don't wrap in middle of word
set linebreak
" move up/down one line as it appears on screen
noremap <Up> gk
noremap <Down> gj
inoremap <Up> <c-o>gk
inoremap <Down> <c-o>gj
" same for home/end
set <Home>=OH
set <End>=OF
noremap <Home> g^
noremap <End> g$
inoremap <Home> <c-o>g^
inoremap <End> <c-o>g$

" go into normal mode in terminal
if exists(':tnoremap')
  tnoremap <Esc><Esc> <c-\><c-n>
endif

" navigate between windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
nnoremap <c-h> <c-w>h

" open terminal in vertical split
command Vter vert ter

" move lines up/down (and reindent to match new pos)
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

let g:netrw_dirhistmax=0

" ##### explorer #####
" hide top banner
let g:netrw_banner = 0
" open files in new vertical split
let g:netrw_browse_split = 2
" set % width
let g:netrw_winsize = 25

" save code folds between sessions
" autocmd BufWinLeave *.* mkview
" autocmd BufWinEnter *.* silent loadview



" add undo action per word
inoremap <Space> <Space><C-g>u
inoremap <c-w> <c-g>u<c-w>
inoremap <c-u> <c-g>u<c-u>

" ########## color scheme ##########
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

syntax on
let g:onedark_hide_endofbuffer=1
let g:onedark_terminal_italics=1
colorscheme onedark

" ##### vimtex #####
let g:tex_flavor='latex'
set conceallevel=1
let g:tex_conceal='abdg'
" disable unreadable conceals
let g:vimtex_syntax_conceal = {
  \ 'math_fracs': 0,
  \ 'math_super_sub': 0
  \ }

" auto compile and clean
augroup vimtex_auto_compile_clean
  au!
  au User VimtexEventQuit VimtexClean
  " au User VimtexEventInitPost VimtexCompile
augroup END


" ##### UltiSnips #####
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsEditSplit = 'context'


" ##### MUComplete #####
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
imap <f2> <plug>(MUcompleteFwd)
imap <s-f2> <plug>(MUcompleteBwd)
" when popup menu visible, enter selects highlighted item
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" ### clang complete ###
let g:clang_library_path = '/usr/lib/llvm-10/lib'
let g:clang_complete_auto = 1

" ##### Pear Tree #####
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


" ##### lightline #####
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



" ##### bufferlist #####
map <silent> <F3> :call BufferList()<CR>


" ##### spellcheck #####
set spelllang=en
"au FileType tex setlocal noautoindent 
"au FileType tex setlocal nocindent 
"au FileType tex setlocal indentexpr=

" snippets file syntax highlighting
" au BufNewFile,BufRead *.snippets set ft=snippets
" au FileType snippets setlocal syntax=snippets


" ##### Goyo.vim #####
let g:goyo_width = '120'
let g:goyo_height = '100%'
autocmd! User GoyoEnter nested call lightline#enable()

" ##### vim-commentary #####
nmap <c-_> gcc
imap <c-_> <c-o>gcc
vmap <c-_> gc

" add brackets around visual selection
vnoremap { xi{}<Esc>P
vnoremap ( xi()<Esc>P
vnoremap [ xi[]<Esc>P

" supo work template
augroup supo_work_template
  au!
  au BufNewFile mrw64*.tex 0r ~/.vim/templates/supotemplate.tex
augroup END
