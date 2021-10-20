" custom bracket closers
let b:pear_tree_pairs = {
  \ '$': {'closer': '$'},
  \ '`': {'closer': "'"}
  \ }
call extend(b:pear_tree_pairs, g:pear_tree_pairs)

" enable spellcheck
setlocal spell
