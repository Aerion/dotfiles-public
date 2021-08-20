# support colors in less
set -gx LESS_TERMCAP_so \e'[01;30;43m' # begin standout-mode – info
set -gx LESS_TERMCAP_mb \e'[01;31m' # enter blinking mode
set -gx LESS_TERMCAP_md \e'[01;38;5;75m' # enter double-bright mode
set -gx LESS_TERMCAP_me \e'[0m' # turn off all appearance modes (mb, md, so, us)
set -gx LESS_TERMCAP_se \e'[0m' # leave standout mode
set -gx LESS_TERMCAP_ue \e'[0m' # leave underline mode
set -gx LESS_TERMCAP_us \e'[04;38;5;200m' # enter underline mode

# set bat as man pager
set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"

# ring bell after command completion to trigger urgency
function bell --on-event fish_postexec
    test -n "$argv"; and echo -n \a
end

# Start X at login on tty1
if status --is-login
    if test -z "$DISPLAY" -a $XDG_VTNR = 1
        exec sway
    end
end

# publish fish_private_mode
if test -n "$fish_private_mode"
    set -x FISH_PRIVATE_MODE $fish_private_mode
end

starship init fish | source

zoxide init fish | source
