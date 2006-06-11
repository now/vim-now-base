" Vim plugin file
" Maintainer:       Nikolai Weibull <now@bitwi.se>
" Latest Revision:  2006-06-12

if exists('loaded_lib_now_system_network')
  finish
endif
let loaded_lib_now_system_network = 1

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
