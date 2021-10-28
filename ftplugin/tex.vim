" custom bracket closers
let b:pear_tree_pairs = {
  \ '$': {'closer': '$'},
  \ '`': {'closer': "'"}
  \ }
call extend(b:pear_tree_pairs, g:pear_tree_pairs)

" enable spellcheck
setlocal spell

" autosave on write
augroup autosave_on_write
  au!
  au TextChanged,TextChangedI <buffer> if &readonly == 0 && filereadable(bufname('%')) | silent write | endif
augroup END
