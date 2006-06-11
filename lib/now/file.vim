" Vim library file
" Maintainer:	    Nikolai Weibull <now@bitwi.se>
" Latest Revision:  2006-06-11

if exists('loaded_lib_now_file')
  finish
endif
let loaded_lib_now_file = 1

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
