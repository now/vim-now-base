let s:cpo_save = &cpo
set cpo&vim

function! now#string#strip(string)
  return substitute(a:string, '^\_s\+\|\_s\+$', '', 'g')
endfunction

function! now#string#trim(string)
  return substitute(a:string, '^\s\+\|\s\+$', '', 'g')
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save
