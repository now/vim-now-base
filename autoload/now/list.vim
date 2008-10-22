let s:cpo_save = &cpo
set cpo&vim

function! now#list#map(expr, string)
  return map(copy(a:expr), a:string)
endfunction

function! now#list#filter(expr, string)
  return filter(copy(a:expr), a:string)
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save
