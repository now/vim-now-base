" Vim autoload file
" Maintainer:       Nikolai Weibull <now@bitwi.se>
" Latest Revision:  2007-06-26

let s:cpo_save = &cpo
set cpo&vim

function now#utilities#list#permute(list)
  if len(a:list) < 2
    return [a:list]
  else
    let permutations = []
    let i = 0
    let n = len(a:list)
    while i < n
      let item = a:list[i]
      let list_copy = copy(a:list)
      call remove(list_copy, i)
      for permutation in s:permute(list_copy)
        call add(permutations, insert(permutation, item))
      endfor
      let i += 1
    endwhile
    return permutations
  endif
endfunction

let &cpo = s:cpo_save
