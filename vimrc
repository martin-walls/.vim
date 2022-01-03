" vim:foldmethod=marker

" set <leader> to <space>
let mapleader=" "

" ┌──────────────────┐
" │ General settings │
" └──────────────────┘
" {{{
set nocompatible
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent
set number
set splitright
set splitbelow
set title
set titlestring=%t%m
set scrolloff=6
set sidescrolloff=8
" set cursorline  # moved to autocmds below
" set hidden
set autowrite
set autowriteall
set clipboard=unnamedplus
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
set foldtext=gitgutter#fold#foldtext()
" minimum number of lines for FastFold to be enabled
let g:fastfold_minlines=0


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
if !has("gui_running")
  hi Normal ctermbg=NONE guibg=NONE
endif

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

" reload vimrc
nnoremap <leader>R :source $MYVIMRC<CR>

" Reselect visual selection after indenting
vnoremap < <gv
vnoremap > >gv

" allow gf to edit non-existent files
map gf :edit <cfile><CR>

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
  " au InsertEnter * norm zz
  " strip trailing spaces on save
  au BufWritePre * %s/\s\+$//e
augroup END

" cursorline only in focused window
augroup CursorLine
  au!
  au VimEnter * setlocal cursorline
  au WinEnter * setlocal cursorline
  au BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

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

" ┌─────────┐
" │ Plugins │
" └─────────┘
" {{{
source ~/.vim/plugins/coc.vim
source ~/.vim/plugins/floaterm.vim
source ~/.vim/plugins/arduino.vim
source ~/.vim/plugins/startify.vim
source ~/.vim/plugins/vimtex.vim
source ~/.vim/plugins/ultisnips.vim
source ~/.vim/plugins/netrw.vim
source ~/.vim/plugins/pear-tree.vim
source ~/.vim/plugins/lightline.vim
source ~/.vim/plugins/goyo.vim
source ~/.vim/plugins/terminus.vim
source ~/.vim/plugins/gitgutter.vim
" }}}
