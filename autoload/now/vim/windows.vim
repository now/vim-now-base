" Vim plugin file
" Maintainer:       Nikolai Weibull <now@bitwi.se>
" Latest Revision:  2007-09-18

let s:cpo_save = &cpo
set cpo&vim

" TODO: Should we keep a list of windows?

function now#vim#windows#find(id)
  if now#vim#is_a(a:id, 'number')
    let number = a:id
  elseif a:id == '.'
    let number = winnr()
  else
    let number = winnr(a:id)
  endif
  return now#vim#window#new(number)
endfunction

function now#vim#windows#current()
  return now#vim#windows#find('.')
endfunction

function now#vim#windows#count()
  return winnr('$')
endfunction

function now#vim#windows#add(name, ...)
  let type = 'normal'
  if a:0 > 0
    let type = a:1['type']
  endif
  execute 'silent! keepjumps keepalt below new' a:name
  if type == 'scratch'
    setlocal modifiable noswapfile buftype=nofile bufhidden=unload nobuflisted
  endif
  return now#vim#window#current()
endfunction

let &cpo = s:cpo_save
