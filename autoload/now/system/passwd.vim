let s:cpo_save = &cpo
set cpo&vim

" The path to the passwd(5) file.
let now#system#passwd#file = '/etc/passwd'

" An internal cache of parsed passwd(5) entries, accessible both by login name
" and user id (UID).
let s:cache = {'logins': {}, 'uids': {}}

" Stores the modification time of the passwd(5) file, after the last time it
" was parsed.
let s:cache_time = -1

" Lookup up the passwd(5) entry in the passwd(5) file for the given user id ID.
" If ID is a number, look up the numeric user-id, otherwise, look it up as a
" login name.
function! now#system#passwd#entry(id)
  call s:parse()
  return type(a:id) == g:now#vim#types.number ?
        \ s:cache.uids[a:id] :
        \ s:cache.logins[a:id]
endfunction

" Parse the passwd(5) file.  If it isn’t readable or if it hasn’t been updated
" since we last parsed it, simply return.  Otherwise walk through the file line
" by line, adding entries to the cache.
function! s:parse()
  if !filereadable(g:now#system#passwd#file) ||
   \ getftime(g:now#system#passwd#file) == s:cache_time
    return
  endif
  for line in readfile(g:now#system#passwd#file)
    let entry = s:parse_line(line)
    let s:cache.logins[entry.name] = entry
    let s:cache.uids[entry.uid] = entry
  endfor
  let s:cache_time = getftime(g:now#system#passwd#file)
endfunction

" Parse a single line in the passwd(5) file.  This is done by splitting the
" line on colons: ‘:’.
function! s:parse_line(line)
  let empty_fields = ["", "", "", "", "", "", ""]
  let parts = split(a:line, ':')
  if len(parts) > 7
    let remaining = remove(parts, 7, -1)
    let parts[6] .= join(remaining, ':')
  elseif len(parts) < 7
    call extend(parts, empty_fields)
    if len(parts) > 7
      call remove(parts, 7, -1)
    endif
  endif
  return call(s:entry.new, parts, s:entry)
endfunction

" Represents a single entry in the passwd(5) file.
let s:entry = {}

" Create a new passwd(5) entry.
function! s:entry.new(name, passwd, uid, gid, gecos, dir, shell) dict
  let entry = deepcopy(self)
  let entry.name = a:name
  let entry.passwd = a:passwd
  let entry.uid = str2nr(a:uid)
  let entry.gid = str2nr(a:gid)
  let entry.gecos = a:gecos
  let entry.dir = a:dir
  let entry.shell = a:shell
  return entry
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save
