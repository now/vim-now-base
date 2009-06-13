let s:cpo_save = &cpo
set cpo&vim

function! now#system#user#email_address()
  if $EMAIL != ""
    return $EMAIL
  elseif $EMAIL_ADDRESS != ""
    " This is some Debian junk if I remember correctly.
    return $EMAIL_ADDRESS
  endif

  let uid = now#system#user#effective_uid()
  let email = now#system#user#login_name(uid) . '@' . now#system#network#hostname()
  let name = now#system#user#full_name(uid)
  if name != ""
    return printf("%s <%s>", name, email)
  endif
  return email
endfunction

function! now#system#user#full_name(...)
  let uid = a:0 > 0 ? a:1 : now#system#user#effective_uid()
  try
    let entry = now#system#passwd#entry(uid)
  catch
    " Maybe the environment has something of interest.
    if a:0 == 0 && $NAME != ""
      return $NAME
    endif

    " No? well, use the login name and capitalize first
    " character.
    let login = now#system#user#login_name(uid)
    if login == ""
      return login
    endif
    return toupper(login[0]) . strpart(login, 1)
  endtry

  let name = entry.gecos

  " Only keep stuff before the first comma.
  let comma = stridx(name, ',')
  if comma != -1
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

function! now#system#user#login_name(...)
  if $LOGNAME != ""
    return $LOGNAME
  elseif $USER != ""
    return $USER
  endif

  let uid = a:0 > 0 ? a:1 : now#system#user#effective_uid()
  try
    let entry = now#system#passwd#entry(uid)
    return entry.name
  catch
    return ""
  endtry
endfunction

function! now#system#user#real_login_name()
  return now#system#user#login_name(now#system#user#uid())
endfunction

function! now#system#user#effective_uid()
  return str2nr(now#string#strip(system("id -u")))
endfunction

function! now#system#user#uid()
  return str2nr(now#string#strip(system("id -ur")))
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save
