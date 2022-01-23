" ┌─────────┐
" │ vimwiki │
" └─────────┘
let cam_wiki = {
      \ "path": "~/UNI/cam-compsci-notes",
      \ "path_html": "~/UNI/cam-compsci-notes/docs",
      \ "syntax": "markdown",
      \ "ext": ".md",
      \ "name": "Cam CompSci Notes Wiki",
      \ "custom_wiki2html": $HOME."/.vim/pack/mrw/start/vimwiki/autoload/vimwiki/customwiki2html.sh"
      \ }
" \ "auto_export": 1

let personal_wiki = {
      \ "path": "~/WIKI",
      \ "syntax": "markdown",
      \ "ext": ".md",
      \ "name": "Personal Wiki",
      \ "links_space_char": "_",
      \ }

let g:vimwiki_markdown_link_ext = 1

let g:vimwiki_list = [personal_wiki, cam_wiki]

let g:vimwiki_customwiki2html=$HOME."/.vim/pack/mrw/start/vimwiki/autoload/vimwiki/customwiki2html.sh"
