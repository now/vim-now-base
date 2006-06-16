" Vim plugin file
" Maintainer:       Nikolai Weibull <now@bitwi.se>
" Latest Revision:  2006-06-16

if exists('loaded_lib_now_system_network')
  finish
endif
let loaded_lib_now_system_network = 1

let s:cpo_save = &cpo
set cpo&vim

let NOW.System.Network = {}

function NOW.System.Network.hostname() dict
  let hostname = system('hostname')
  if v:shell_error
    return 'localhost'
  endif

  let newline = stridx(hostname, "\n")
  if newline != -1
    return strpart(hostname, 0, newline)
  endif
  
  return hostname
endfunction

let &cpo = s:cpo_save
