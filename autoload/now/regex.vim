" Vim autoload file
" Maintainer:       Nikolai Weibull <now@bitwi.se>
" Latest Revision:  2006-11-07

let s:cpo_save = &cpo
set cpo&vim

function now#regex#escape(string)
  " TODO: need to deal with $
  return escape(a:string, '\.^$~[]')
endfunction

function now#regex#new(pattern)
  let regex = deepcopy(g:now#regex#object)
  let regex.pattern = '\m' . a:pattern
  return regex
endfunction

let now#regex#object = {}

function now#regex#object.sub(string, with, ...) dict
  let options = a:0 > 0 ? a:1 : ""
  return substitute(a:string, self.pattern, a:with, options)
endfunction

function now#regex#object.gsub(string, with, ...) dict
  let options = a:0 > 0 ? a:1 : ""
  let options .= 'g'
  return call(self.sub, [a:string, a:with, options], self)
endfunction

let &cpo = s:cpo_save
