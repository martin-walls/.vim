" use 2 spaces for tab
set tabstop=2
set shiftwidth=2
set expandtab

" show line numbers
set number

set autoindent


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
colorscheme onedark

" vim-plug
set nocompatible
call plug#begin('~/.vim/plugged')

" bracket auto close
Plug 'tmsvg/pear-tree'

" lots of languages support
Plug 'sheerun/vim-polyglot'

" lightline bottom bar
Plug 'itchyny/lightline.vim'

" git integration
Plug 'tpope/vim-fugitive'

" fuzzy file search
Plug 'ctrlpvim/ctrlp.vim'

" latex
Plug 'lervag/vimtex'
let g:tex_flavor='latex'
set conceallevel=1
let g:tex_conceal='abdmg'

Plug 'sirver/ultisnips'
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsEditSplit = 'context'

call plug#end()

" pear tree
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

" filetype specific pairs
augroup html_pairs
  autocmd!
  autocmd FileType html let b:pear_tree_pairs = {
    \ '<*>': {'closer': '</*>', 'not_if': ['br', 'meta']}
    \ }
augroup END

augroup js_pairs
  autocmd!
  autocmd FileType js let b:pear_tree_pairs = {
    \ '<*>': {'closer': '</*>', 'not_if': ['br', 'meta']}
    \ }
augroup END

augroup latex_pairs
  autocmd!
  autocmd FileType tex let b:pear_tree_pairs = {
    \ '$': {'closer': '$'}
    \ }
augroup END

" smart pairs
let g:pear_tree_smart_openers = 1
let g:pear_tree_smart_closers = 1
let g:pear_tree_smart_backspace = 1

" make lightline show
set laststatus=2
" disable default -- INSERT -- etc
set noshowmode
" lightline config
let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
  \ },
  \ 'component_function': {
  \   'gitbranch': 'FugitiveHead'
  \ },
  \ }


" save and load code folds automatically
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview


augroup vimtex_auto_compile_clean
  au!
  au User VimtexEventQuit VimtexClean
  au User VimtexEventInitPost VimtexCompile
augroup END
