# Time-Ago.vim

A neovim & vim plugin to convert a unix timestamp into a set of day, hour, minute, second components or into a fuzzy phrase.

Example output of components:

    1550489773 => 15 days, 10 hours, 40 minutes, 13 seconds ago => {'days': 15, 'hours': 10, 'minutes': 40, 'seconds': 13}

Example output of fuzzy:

    1550489773 => 15 days, 10 hours, 40 minutes, 13 seconds ago => 2 weeks
    11 days => 1 week, 4 days
    7 days => 1 week
    5 days => 5 days
    2 days, 10 hours, 33 minutes, 32 seconds ago => 2 days, 10 hours
    8 hours, 10 minutes, 30 seconds ago => 8 hours ago
    4 hours, 35 minutes, 56 seconds ago => 4 hours, 30 minutes
    1 hour, 16 minutes, 40 seconds ago => 1 hour, 15 minutes
    46 minutes, 40 seconds ago => 40 minutes
    27 minutes, 20 seconds ago => 25 minutes
    8 minutes, 44 seconds ago => 8 minutes
    33 seconds => under a minute
 
Note: times could be more accurately considered truncated than rounded, i.e. `8 hours, 10 minutes => 8 hours, 8 hours, 59 minutes => 8 hours`.

Times are left 'undecorated' for you to alter as desired (i.e. '8 minutes ago', '~ 8 minutes', substituting 'm' for 'minutes', translated substitutions, etc).

# Installation

## Using `vim-plug`

    Plug 'rktjmp/time-ago.vim'

# Usage

    l:timestamp = localtime() - (60 * 60 * 24 * 3) " 3 days ago
    l:fuzzed = time_ago#fuzzy_from_now(l:timestamp)
    " => 3 days
    l:components = time_ago#components_from_now(l:timestamp)
    " => {days: 3, hours: 0, minutes: 0, seconds: 0}
