" Vim plugin file
" Maintainer:       Nikolai Weibull <now@bitwi.se>
" Latest Revision:  2006-06-12

if exists('loaded_lib_now_system_passwd')
  finish
endif
let loaded_lib_now_system_passwd = 1

let NOW.System.Passwd = {}

let NOW.System.Passwd.file = '/etc/passwd'
let NOW.System.Passwd.cache = {'logins': {}, 'uids': {}}
let NOW.System.Passwd.cache_time = -1

function NOW.System.Passwd.entry(id) dict
  return type(a:id) == 0 ? self.cache.uids[a:id] : self.cache.logins[a:id]
endfunction

function NOW.System.Passwd.parse() dict
  if !filereadable(self.file)
    return {}
  endif
  if getftime(self.file) == self.cache_time
    return self.cache
  endif
  for line in readfile(self.file)
    let entry = self.parse_line(line)
    let self.cache.logins[entry.name] = entry
    let self.cache.uids[entry.uid] = entry
  endfor
  return self.cache
endfunction

function NOW.System.Passwd.parse_line(line) dict
  let parts = split(a:line, ':')
  let remaining = remove(parts, 8, -1)
  let parts[6] .= join(remaining, ':')
  let entry = call(self.Entry.new, parts, self.Entry)
endfunction

let NOW.System.Passwd.Entry = {}

function NOW.System.Passwd.Entry.new(account, passwd, uid, gid, gecos,
                                   \ directory, shell) dict
  let entry = deepcopy(self)
  let entry.account = a:account
  let entry.passwd = a:passwd
  let entry.uid = a:uid
  let entry.gid = a:gid
  let entry.gecos = a:gecos
  let entry.directory = a:directory
  let entry.shell = a:shell
  return entry
endfunction
