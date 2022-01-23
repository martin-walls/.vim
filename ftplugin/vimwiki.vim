" enable spellcheck
setlocal spell

" autosave on write
augroup autosave_on_write
  au!
  au TextChanged,TextChangedI <buffer> if &readonly == 0 && filereadable(bufname('%')) | silent write | endif
augroup END

" custom bracket closers
let b:pear_tree_pairs = {
  \ '$': {'closer': '$'},
  \ '`': {'closer': '`'},
  \ }
call extend(b:pear_tree_pairs, g:pear_tree_pairs)

" add bold/italic around visual selection
vnoremap <leader>b xi****<Esc><Left>P
vnoremap <leader>i xi**<Esc>P

" map <F2> call UltiSnips#ExpandSnippetOrJump()
" noremap <s-F4> call UltiSnips#JumpBackwards()

" let g:vimwiki_table_mappings = 0
