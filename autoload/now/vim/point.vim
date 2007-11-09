" Vim plugin file
" Maintainer:       Nikolai Weibull <now@bitwi.se>
" Latest Revision:  2007-11-09

let s:cpo_save = &cpo
set cpo&vim

function now#vim#point#new(where)
  let point = deepcopy(g:now#vim#point#object)
  call point.set(getpos(a:where))
  return point
endfunction

function now#vim#point#current()
  return now#vim#point#new('.')
endfunction

let now#vim#point#object = {}

function now#vim#point#object.to_a() dict
  return [self.buffer, self.line, self.column, self.offset]
endfunction

function now#vim#point#object.goto() dict
  call setpos('.', self.to_a())
endfunction

function now#vim#point#object.from(array) dict
  let [self.buffer, self.line, self.column, self.offset] = array
endfunction

function now#vim#point#object.set(other) dict
  call self.from(other.to_a())
endfunction

let &cpo = s:cpo_save
