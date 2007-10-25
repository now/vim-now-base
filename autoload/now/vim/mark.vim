" Vim plugin file
" Maintainer:       Nikolai Weibull <now@bitwi.se>
" Latest Revision:  2007-09-26

let s:cpo_save = &cpo
set cpo&vim

function now#vim#mark#new(where)
  let mark = deepcopy(g:now#vim#mark#object)
  let [mark.buffer, mark.line, mark.column, mark.offset] =
        \ getpos(a:where)
  let mark.winline = winline()
  return mark
endfunction

function now#vim#mark#cursor()
  return now#vim#mark#new('.')
endfunction

let now#vim#mark#object = {}

function now#vim#mark#object.restore() dict
  execute self.buffer . 'wincmd w'
  call cursor(self.line - self.winline + 1, 1)
  normal! zt
  call cursor(self.line, self.column, self.offset)
endfunction

let &cpo = s:cpo_save
