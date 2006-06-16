" Vim library file
" Maintainer:       Nikolai Weibull <now@bitwi.se>
" Latest Revision:  2006-06-16

if exists('loaded_lib_now_vim')
  finish
endif
let loaded_lib_now_vim = 1

let s:cpo_save = &cpo
set cpo&vim

let NOW.Vim = {}

" Find a variable 'varname' in the buffer-local namespace or in the global
" namespace.
function NOW.Vim.b_or_g(varname, ...)
  if exists('b:' . a:varname)
    return eval('b:' . a:varname)
  elseif exists('g:' . a:varname)
    return eval('g:' . a:varname)
  else
    return (a:0 > 0) ? a:1 : ""
  endif
endfunction

let &cpo = s:cpo_save
