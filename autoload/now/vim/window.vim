let s:cpo_save = &cpo
set cpo&vim

function! now#vim#window#new(number)
  let window = deepcopy(g:now#vim#window#object)
  let window.number = a:number
  let window.closed = 0
  return window
endfunction

function! now#vim#window#current()
  return now#vim#window#new(winnr())
endfunction

let now#vim#window#object = {}

function! now#vim#window#object.activate() dict
  execute self.number . 'wincmd w'
endfunction

function! now#vim#window#object.height() dict
  return winheight(self.number)
endfunction

function! now#vim#window#object.width() dict
  return winheight(self.number)
endfunction

function! now#vim#window#object.buffer() dict
  return now#vim#buffers#find(winbufnr(self.number))
endfunction

function! now#vim#window#object.close()
  call self.activate()
  silent! close!
  let self.closed = 1
endfunction

let now#vim#window#null = now#vim#window#new(-1)
let now#vim#window#null.closed = 1

function! now#vim#window#null()
  return g:now#vim#window#null
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save
