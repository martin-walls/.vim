" enable spellcheck
setlocal spell

" autosave on write
augroup autosave_on_write
  au!
  au TextChanged,TextChangedI <buffer> if &readonly == 0 && filereadable(bufname('%')) | silent write | endif
augroup END
