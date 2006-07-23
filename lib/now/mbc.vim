" Vim plugin file
" Maintainer:       Nikolai Weibull <now@bitwi.se>
" Latest Revision:  2006-07-23

if exists('loaded_lib_now_mbc')
  finish
endif
let loaded_lib_now_mbc = 1

let s:cpo_save = &cpo
set cpo&vim

let NOW.MBC = {}

function NOW.MBC.len(str)
  return strlen(substitute(a:str, '.', 'c', 'g'))
endfunction

" TODO: This is of course not strictly true, but it’s good enough for a start.
function NOW.MBC.width(str) dict
  return self.len(a:str)
endfunction

function NOW.MBC.part(str, start, ...)
  return join(split(a:str, '\zs')[(a:start):(a:0 > 0 ? a:1 : -1)], "")
endfunction

let &cpo = s:cpo_save
