" Vim plugin file
" Maintainer:	    Nikolai Weibull <now@bitwi.se>
" Latest Revision:  2006-06-16

if exists('loaded_lib_now_vim_motion')
  finish
endif
let loaded_lib_now_vim_motion = 1

let s:cpo_save = &cpo
set cpo&vim

let NOW.Vim.Motion = {}

function NOW.Vim.Motion.iterate_lines_not_matching(pattern, ...) dict
  return call(self.iterate_lines, extend([0, a:pattern], a:000), self)
endfunction

function NOW.Vim.Motion.iterate_lines_matching(pattern, ...) dict
  return call(self.iterate_lines, extend([1, a:pattern], a:000), self)
endfunction

function NOW.Vim.Motion.iterate_lines(matching, pattern, ...) dict
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
