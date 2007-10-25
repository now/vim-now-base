" Vim plugin file
" Maintainer:	    Nikolai Weibull <now@bitwi.se>
" Latest Revision:  2007-09-16

let s:cpo_save = &cpo
set cpo&vim

function now#vim#motion#iterate_lines_not_matching(pattern, ...)
  return call('s:iterate_lines', extend([0, a:pattern], a:000))
endfunction

function now#vim#motion#iterate_lines_matching(pattern, ...)
  return call('s:iterate_lines', extend([1, a:pattern], a:000))
endfunction

function s:iterate_lines(matching, pattern, ...)
  let lnum = (a:0 > 0 && a:1 > 0) ? a:1 : 1
  let end = (a:0 > 1 && a:2 > 0) ? a:2 : line('$') + 1
  while lnum < end
    let line = getline(lnum)
    let matched = line =~ a:pattern
    if (a:matching && !matched) || (!a:matching && matched)
      break
    endif
    if a:0 > 2
      let continue = (a:0 > 3) ? call(a:3, [line, lnum], a:4) : call(a:3, [line, lnum])
      if !continue
        break
      endif
    endif
    let lnum += 1
    let end = (a:0 > 1 && a:2 > 0) ? a:2 : line('$') + 1
  endwhile
  return lnum
endfunction

let &cpo = s:cpo_save
