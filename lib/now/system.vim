" Vim plugin file
" Maintainer:       Nikolai Weibull <now@bitwi.se>
" Latest Revision:  2006-06-16

if exists('loaded_lib_now_system')
  finish
endif
let loaded_lib_now_system = 1

let s:cpo_save = &cpo
set cpo&vim

let NOW.System = {}

let &cpo = s:cpo_save
