" Vim plugin file
" Maintainer:       Nikolai Weibull <now@bitwi.se>
" Latest Revision:  2007-09-19

let s:cpo_save = &cpo
set cpo&vim

augroup now-vim-buffers-mru
  autocmd BufAdd    * silent call g:now#vim#buffers#list.push()
  autocmd BufDelete * silent call g:now#vim#buffers#list.pop()

  autocmd BufEnter  * silent call g:now#vim#buffers#mru.push()
  autocmd BufDelete * silent call g:now#vim#buffers#mru.pop()
augroup end

" TODO: does it make sense to keep a list?

let now#vim#buffers#list = {}

function now#vim#buffers#list.build() dict
  let self.list = []
  let i = 0
  while i < bufnr('$')
    let i += 1
    if !bufexists(i)
      continue
    endif
    call add(self.list, now#vim#buffer#new(i))
  endwhile
endfunction

function now#vim#buffers#list.push() dict
  call add(self.list, now#vim#buffer#new(str2nr(expand('<abuf>'))))
endfunction

function now#vim#buffers#list.pop() dict
  call self.remove(str2nr(expand('<abuf>')))
endfunction

function now#vim#buffers#list.remove(buffer) dict
  let index = self.index(a:buffer)
  if index != -1
    call remove(self.list, index)
  endif
endfunction

function now#vim#buffers#list.index(number) dict
  let index = 0
  for buffer in self.list
    if buffer.number == a:number 
      return index
    endif
    let index += 1
  endfor
  return -1
endfunction

function now#vim#buffers#list.count() dict
  return len(self.list)
endfunction

function now#vim#buffers#list.item(index) dict
  return self.list[a:index]
endfunction

let now#vim#buffers#mru = deepcopy(now#vim#buffers#list)

function! now#vim#buffers#mru.push() dict
  let buffer = now#vim#buffer#new(bufnr('%'))
  if !buffer.listed()
    return
  endif
  call self.remove(buffer.number)
  call insert(self.list, buffer, 0)
endfunction

function now#vim#buffers#to_a(...)
  let order = a:0 > 0 ? a:1 : 'creation'
  let filter = a:0 > 1 ? a:2 : 'all'

  if order == 'creation'
    let buffers = copy(g:now#vim#buffers#list.list)
  elseif order == 'mru'
    let buffers = copy(g:now#vim#buffers#mru.list)
  else
    throw 'unknown buffer-list order'
  endif

  if filter == 'all'
    return buffers
  elseif filter == 'listed'
    return filter(buffers, 'v:val.listed()')
  else
    throw 'unknown buffer-list filter'
  endif
endfunction

function now#vim#buffers#count()
  return g:now#vim#buffers#list.count()
endfunction

function now#vim#buffers#item(index)
  return g:now#vim#buffers#list.item(a:index)
endfunction

function now#vim#buffers#find(id)
  return now#vim#buffers#item(g:now#vim#buffers#list.index(bufnr(a:id)))
endfunction

function now#vim#buffers#current()
  return now#vim#buffers#find('%')
endfunction

function now#vim#buffers#alternate()
  return now#vim#buffers#find(0)
endfunction

call now#vim#buffers#list.build()
call now#vim#buffers#mru.build()

" function NOW.Vim.Buffers.add()
" function NOW.Vim.Buffers.open()

let &cpo = s:cpo_save
