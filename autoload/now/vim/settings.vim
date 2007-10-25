" Vim autoload file
" Maintainer:       Nikolai Weibull <now@bitwi.se>
" Latest Revision:  2007-09-19

let s:cpo_save = &cpo
set cpo&vim

function now#vim#settings#fillchar(char, ...)
  let default = ""
  if a:0 > 1
    let default = a:1
  endif
  let fillchar = &fillchars[matchend(&fillchars, a:char . ':')]
  return (fillchar != "" ? fillchar : default)
endfunction

let s:cpo_save = &cpo
set cpo&vim
