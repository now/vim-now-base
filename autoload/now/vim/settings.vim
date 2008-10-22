let s:cpo_save = &cpo
set cpo&vim

function! now#vim#settings#fillchar(char, ...)
  let default = ""
  if a:0 > 1
    let default = a:1
  endif
  let fillchar = &fillchars[matchend(&fillchars, a:char . ':')]
  return (fillchar != "" ? fillchar : default)
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save
