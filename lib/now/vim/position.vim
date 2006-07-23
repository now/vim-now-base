" Vim plugin file
" Maintainer:       Nikolai Weibull <now@bitwi.se>
" Latest Revision:  2006-07-18

if exists('loaded_lib_now_vim_position')
  finish
endif
let loaded_lib_now_vim_position = 1

let s:cpo_save = &cpo
set cpo&vim

let NOW.Vim.Position = {}

function NOW.Vim.Position.current() dict
  let position = deepcopy(self)
  let [position.buffer, position.lnum, position.column, position.offset] =
        \ getpos('.')
  let position.winline = winline()
  return position
endfunction

function NOW.Vim.Position.restore() dict
  execute self.buffer . 'wincmd w'
  call cursor(self.lnum - self.winline + 1, 1)
  normal! zt
  call cursor(self.lnum, self.column, self.offset)
endfunction

let &cpo = s:cpo_save
