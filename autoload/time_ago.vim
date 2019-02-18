if exists('g:time_ago') || &cp 
endif

augroup time_ago_augroup
  autocmd!
augroup END

function! time_ago#components(timestamp, ...)
  let l:now = localtime()
  let l:age = l:now - a:timestamp

  let l:days = l:age / 60 / 60 / 24
  let l:hours = l:age / 60 / 60 % 24
  let l:minutes = l:age / 60 % 60
  let l:seconds = l:age % 60

  let l:components = {
        \ 'days': l:days,
        \ 'hours': l:hours,
        \ 'minutes': l:minutes,
        \ 'seconds': l:seconds,
        \ }

  return l:components
endfunction

function! time_ago#fuzzy(timestamp, ...)
  let l:components = time_ago#components(a:timestamp)

  let l:days = l:components.days
  let l:hours = l:components.hours
  let l:minutes = l:components.minutes
  let l:seconds = l:components.seconds

  let l:phrase = ""

  if l:days > 14
    " ~ 2 weeks
    " ~ 4 weeks
    let l:weeks = l:days / 7
    let l:phrase = l:weeks . ' weeks'
    return l:phrase
  endif

  if l:days > 7
    " ~ 1 week, 4 days
    " ~ 1 week, 1 day
    let l:weeks = l:days / 7
    if l:weeks > 1
      let l:phrase = l:weeks . ' weeks'
    else
      let l:phrase = l:weeks . ' week'
    endif
    let l:days = l:days % 7
    if l:days > 1
      let l:phrase .= ', ' . l:days . ' days'
    elseif l:days == 1
      let l:phrase .= ', ' . l:days . ' day'
    endif
    return l:phrase
  endif

  if l:days == 7
    " ~ 1 week
    let l:phrase = '1 week'
    return l:phrase
  endif

  if l:days > 2
    " ~ 6 days
    " ~ 2 days
    let l:phrase = l:days . ' days'
    return l:phrase
  endif

  if l:days > 0
    " ~ 2 days, 4 hours
    " ~ 2 days
    " ~ 1 day, 1 hour
    " ~ 1 day
    if l:days == 2
      let l:phrase = '2 days'
    else
      let l:phrase = '1 day'
    endif
    if l:hours > 0
      let l:phrase .= ', ' . l:hours . ' hours'
    endif
    return l:phrase
  endif

  if l:hours > 6
    " ~ 18 hours
    " ~ 6 hours
    let l:phrase = l:hours . ' hours'
    return l:phrase
  endif

  if l:hours > 1
    " ~ 6 hours, 45 minutes
    " ~ 5 hours, 45 minutes
    " ~ 2 hours
    let l:phrase = l:hours . ' hours'
    let l:fifteens = (l:minutes / 15) * 15
    if l:fifteens > 0
      let l:phrase .= ', ' . l:fifteens . ' minutes'
    endif
    return l:phrase
  endif

  if l:hours == 1
    " ~ 1 hour
    let l:phrase = l:hours . ' hour'
    let l:fifteens = (l:minutes / 15) * 15
    if l:fifteens > 0
      let l:phrase .= ', ' . l:fifteens . ' minutes'
    endif
    return l:phrase
  endif

  if l:minutes > 31
    " ~ 50 minutes
    " ~ 40 minutes
    " ~ 30 minutes
    let l:tens = (l:minutes / 10) * 10
    let l:phrase = l:tens . ' minutes'
    return l:phrase
  endif

  if l:minutes > 10
    " ~ 30 minutes
    " ~ 25 minutes
    " ~ 10 minutes
    let l:fives = (l:minutes / 5) * 5
    let l:phrase = l:fives . ' minutes'
    return l:phrase
  endif

  if l:minutes > 1
    let l:phrase = l:minutes . ' minutes'
    return l:phrase
  endif

  if l:minutes == 1
    let l:phrase = '1 minute'
    return l:phrase
  endif

  let l:phrase = 'under a minute'
  return l:phrase
endfunction
