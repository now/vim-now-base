let s:cpo_save = &cpo
set cpo&vim

" Retrieve the system hostname through the command hostname(1), removing the
" first newline and anything that follows it.  If this fails, return
" “localhost”.
function! now#system#network#hostname()
  let hostname = system('hostname')
  if v:shell_error
    return 'localhost'
  endif

  return substitute(hostname, '\n.*$', "", "")
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save
