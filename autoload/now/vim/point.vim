" Vim plugin file
" Maintainer:       Nikolai Weibull <now@bitwi.se>
" Latest Revision:  2007-11-09

let s:cpo_save = &cpo
set cpo&vim

function now#vim#point#new(where)
  let point = deepcopy(g:now#vim#point#object)
  call point.set(a:where)
  return point
endfunction

function now#vim#point#cursor()
  return now#vim#point#new(getpos('.'))
endfunction

function now#vim#point#first()
  return now#vim#point#new([0, 1, 1, 0])
endfunction

function now#vim#point#last()
  return now#vim#point#new([0, line('$'), col(line('$'), '$'), 0])
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
