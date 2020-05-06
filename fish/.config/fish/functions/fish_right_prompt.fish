# Colors
function orange
    set_color -o ee5819
end

function yellow
    set_color -o ffd787
end

function cyan
    set_color -o 86d8fa
end

function white
    set_color -o fdf6e3
end

function dim
    set_color -o 4f4f4f
end

function off
    set_color -o normal
end

function fish_right_prompt
    set -l jobs_count (jobs -p 2>/dev/null | wc -l)

    if test $jobs_count -gt 0
        echo "[$jobs_count] "
    end

    set -g __fish_git_prompt_show_informative_status
    set -g __fish_git_prompt_showcolorhints
    set -g __fish_git_prompt_showupstream "git"
    set -g __fish_git_prompt_describe_style "describe"
    set -g __fish_git_prompt_showdirtystate

    fish_git_prompt
end
