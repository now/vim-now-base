" Vim plugin file
" Maintainer:       Nikolai Weibull <now@bitwi.se>
" Latest Revision:  2006-06-16

if exists('loaded_lib_now_system_user')
  finish
endif
let loaded_lib_now_system_user = 1

let s:cpo_save = &cpo
set cpo&vim

let NOW.System.User = {}

function NOW.System.User.email_address() dict
  if $EMAIL != ""
    return $EMAIL
  elseif $EMAIL_ADDRESS != ""
    " This is some Debian junk if I remember correctly.
    return $EMAIL_ADDRESS
  endif

  let uid = self.effective_uid()
  let email = self.login_name(uid) . '@' . NOW.System.Network.hostname()
  let name = self.full_name(uid)
  if name != ""
    return printf("%s <%s>", name, email)
  endif
  return email
endfunction

function NOW.System.User.full_name() dict
  let uid = a:0 > 0 ? a:1 : self.effective_uid()
  try
    let entry = NOW.System.Passwd.entry(uid)
  catch
    " Maybe the environment has something of interest.
    if a:0 == 0 && $NAME != ""
      return $NAME
    endif

    " No? well, use the login name and capitalize first
    " character.
    let login = self.login_name(uid)
    if login == ""
      return login
    endif
    return toupper(login[0]) . strpart(login, 1)
  end

  let name = entry.gecos

  " Only keep stuff before the first comma.
  let end = stridx(name, ',')
  if end != -1
    let name = strpart(name, 0, comma)
  endif

  " And substitute & in the real name with the login of our user.
  let amp = stridx(name, '&')
  if amp != -1
    let name = strpart(name, 0, amp) . toupper(login[0]) .
              \ strpart(login, 1) . strpart(name, amp + 1)
  endif

  return name
endfunction

function NOW.System.User.login_name(...) dict
  if $LOGNAME != ""
    return $LOGNAME
  elseif $USER != ""
    return $USER
  endif

  let uid = a:0 > 0 ? a:1 : self.effective_uid()
  try
    let entry = NOW.System.Passwd.entry(uid)
    return entry.account
  catch
    return ""
  endtry
endfunction

function NOW.System.User.real_login_name() dict
  return self.login_name(self.uid())
endfunction

function NOW.System.User.effective_uid() dict
  return $EUID
endfunction

function NOW.System.User.uid() dict
  return $UID
endfunction

let &cpo = s:cpo_save
