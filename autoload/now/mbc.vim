" Vim plugin file
" Maintainer:       Nikolai Weibull <now@bitwi.se>
" Latest Revision:  2007-09-20

let s:cpo_save = &cpo
set cpo&vim

function now#mbc#len(str)
  return strlen(substitute(a:str, '.', 'c', 'g'))
endfunction

" TODO: This is of course not strictly true, but it’s good enough for a start.
function now#mbc#width(str)
  return now#mbc#len(a:str)
endfunction

function now#mbc#part(str, start, ...)
  return join(split(a:str, '\zs')[(a:start):(a:0 > 0 ? a:1 : -1)], "")
endfunction

let &cpo = s:cpo_save
