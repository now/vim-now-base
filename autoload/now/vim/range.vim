let s:cpo_save = &cpo
set cpo&vim

function! now#vim#range#new(begin, ...)
  let range = deepcopy(g:now#vim#range#object)
  let range.begin = a:begin
  let range.end = a:0 > 0 ? a:000[0] : range.begin
  return range
endfunction

function! now#vim#range#cursor()
  return now#vim#range#new(now#vim#point#cursor())
endfunction

function! now#vim#range#all()
  return now#vim#range#new(now#vim#point#first(), now#vim#point#last())
endfunction

let now#vim#range#object = {}

function! now#vim#range#object.delete() dict
  if self.end.line != self.begin.line
    call self.begin.goto()
    normal! "_d$
    if self.end.line > self.begin.line + 1
      execute (self.begin.line + 1) . ',' . (self.end.line - 1) . 'delete "_'
    endif
    call self.end.goto()
    call now#vim#execute_with_settings("normal! \"_d0i\<BS>", {'backspace': 'eol'})
  else
    call self.begin.goto()
    let n = self.end.column - self.begin.column
    execute 'normal! "_d' . n . 'l'
  endif
  call self.end.set(self.begin)
  call self.begin.goto()
endfunction

function! now#vim#range#object.insert(text) dict
  let lines = split(a:text, '\n')
  let line = remove(lines, 0)
  let old_line = getline(self.begin.line)
  call setline(self.begin.line,
             \ strpart(old_line, 0, self.begin.column - 1) . line)
  if len(lines) > 0
    call append(self.begin.line, lines)
  endif
  let last_lnum = self.begin.line + len(lines)
  let last_line = getline(last_lnum)
  call setline(last_lnum,
             \ getline(last_lnum) . strpart(old_line, self.begin.column - 1))
  let self.end.line += len(lines)
  if len(lines) == 0
    if self.end.line == self.begin.line
      let self.end.column += len(line)
    endif
  else
    if self.end.line == last_lnum
      let self.end.column += len(lines[-1]) - (self.begin.column - 1)
    endif
  endif
  call self.end.goto()
endfunction

function! now#vim#range#object.replace(replacement) dict
  call self.delete()
  call self.insert(a:replacement)
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save
