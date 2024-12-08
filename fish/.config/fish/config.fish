# Set bat as man pager
set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"

# Publish fish_private_mode so that starship can display it in the prompt
if test -n "$fish_private_mode"
    set -x FISH_PRIVATE_MODE $fish_private_mode
end

# Set abbreviations
## Git
abbr --add gs git status
abbr --add gd git diff
abbr --add ga git add
abbr --add gl git log
abbr --add gc git commit
abbr --add gca git commit --amend
abbr --add gcae git commit --amend --no-edit
abbr --add gcaa git commit -a --amend
abbr --add gcaae git commit -a --amend --no-edit
abbr --add gcm git commit -m
abbr --add glod git log --oneline decorate
abbr --add gpl git pull
abbr --add gps git push

## File managemnet
abbr --add cp rsync -av --progress
abbr --add mv mv -iv
abbr --add rm timeout 3 rm -Iv --one-file-system

## Clipboard
abbr --add xob pbpaste
abbr --add xib pbcopy

starship init fish | source
zoxide init fish | source
