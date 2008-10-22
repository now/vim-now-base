let s:cpo_save = &cpo
set cpo&vim

function! now#vim#buffer#new(id)
  let buffer = deepcopy(g:now#vim#buffer#object)
  let buffer.number = bufnr(a:id)
  return buffer
endfunction

let now#vim#buffer#object = {}

function! now#vim#buffer#object.exists() dict
  return bufexists(self.number)
endfunction

function! now#vim#buffer#object.listed() dict
  return buflisted(self.number)
endfunction

"function now#vim#buffer#object.hidden() dict
"  return getbufvar(self.number, '&hidden')
"endfunction

function! now#vim#buffer#object.loaded() dict
  return bufloaded(self.number)
endfunction

function! now#vim#buffer#object.name() dict
  return bufname(self.number)
endfunction

function! now#vim#buffer#object.window() dict
  return now#vim#window#new(bufwinnr(self.number))
endfunction

function! now#vim#buffer#object.cleaned_name() dict
  let name = self.name()
  let cwd = getcwd()
  if cwd != ""
    let index = stridx(name, cwd)
    if index != -1
      let name = strpart(name, 0, index) . strpart(name, index + strlen(cwd) + 1)
    endif
  endif
  if exists("$HOME") && $HOME != ""
    let index = stridx(name, $HOME)
    if index == 0
      let name = '~' . strpart(name, index + strlen($HOME))
    endif
  endif
  return name
endfunction

function! now#vim#buffer#object.displayable_name() dict
  let name = self.cleaned_name()
  return name == "" ? '[No Name]' : name
endfunction

function! now#vim#buffer#object.delete() dict
  execute 'bdelete' self.number
endfunction

function! now#vim#buffer#object.activate() dict
  execute 'buffer' self.number
endfunction

function! now#vim#buffer#object.split() dict
  execute 'sbuffer' self.number
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save
