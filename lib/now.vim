" Vim plugin file
" Maintainer:       Nikolai Weibull <now@bitwi.se>
" Latest Revision:  2006-06-09

if exists('loaded_now')
  finish
endif
let loaded_now = 1

let NOW = {}

" Load all VimL files found in “our” directory.  This lets us stuff a lot of
" different plugins in there without clobbering up the top-level
" plugin-directory.
" runtime lib/now/*.vim
