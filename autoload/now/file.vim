" Vim library file
" Maintainer:	    Nikolai Weibull <now@bitwi.se>
" Latest Revision:  2006-11-07

let s:cpo_save = &cpo
set cpo&vim

let now#file#separator = '/'
let now#file#normalization_pattern =
      \ now#regex#new(now#regex#escape(now#file#separator) . '\{2,}')

function now#file#join(...)
  return now#file#normalize_path(join(a:000, g:now#file#separator))
endfunction

function now#file#normalize_path(path)
  return g:now#file#normalization_pattern.sub(a:path, g:now#file#separator, 'g')
endfunction

let &cpo = s:cpo_save
