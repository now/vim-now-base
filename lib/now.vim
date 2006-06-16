" Vim plugin file
" Maintainer:       Nikolai Weibull <now@bitwi.se>
" Latest Revision:  2006-06-16

if exists('loaded_lib_now')
  finish
endif
let loaded_lib_now = 1

let s:cpo_save = &cpo
set cpo&vim

let NOW = {}

" Load all VimL files found in “our” directory.  This lets us stuff a lot of
" different plugins in there without clobbering up the top-level
" plugin-directory.
" runtime lib/now/*.vim

let &cpo = s:cpo_save
