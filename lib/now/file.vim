" Vim library file
" Maintainer:	    Nikolai Weibull <now@bitwi.se>
" Latest Revision:  2006-06-16

if exists('loaded_lib_now_file')
  finish
endif
let loaded_lib_now_file = 1

let s:cpo_save = &cpo
set cpo&vim

let NOW.File = {}

let NOW.File.ComponentSeparator = '/'

function NOW.File.join(...) dict
  let cs_pattern = self.ComponentSeparator . '$'
  let components = copy(a:000)
  let name = remove(components, 0)
  for component in components
    if component !~ cs_pattern
      let name .= self.ComponentSeparator
    endif
    let name .= component
  endfor
  return name
endfunction

let &cpo = s:cpo_save
