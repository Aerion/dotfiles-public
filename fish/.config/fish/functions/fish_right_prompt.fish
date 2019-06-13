# Colors
function orange
    set_color -o ee5819
end

function yellow
    set_color -o ffd787
end

function red
    set_color -o d75f5f
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

# Git
function git::is_repo
    if not test -d .git -a -r .git
        return 1
    end
    command git rev-parse --git-dir >/dev/null ^/dev/null
end

function git::ahead -a ahead behind diverged none
    set -l commit_count (command git rev-list --count --left-right "@{upstream}...HEAD" ^/dev/null)

    switch "$commit_count"
        case ""
            # no upstream
        case "0"\t"0"
            test -n "$none"; and echo "$none"; or echo ""
        case "*"\t"0"
            test -n "$behind"; and echo "$behind"; or echo "-"
        case "0"\t"*"
            test -n "$ahead"; and echo "$ahead"; or echo "+"
        case "*"
            test -n "$diverged"; and echo "$diverged"; or echo "±"
    end
end

function git::branch_name
    begin
        command git symbolic-ref --short HEAD ^/dev/null;
        or command git show-ref --head -s --abbrev | head -n1 ^/dev/null
    end
end

function git::is_dirty
    not command git diff --no-ext-diff --quiet --exit-code
end

function git::is_staged
    not command git diff --cached --no-ext-diff --quiet --exit-code
end

function git::is_stashed
    command git rev-parse --verify --quiet refs/stash >/dev/null
end

function git::is_touched
    test -n (echo (command git status --porcelain))
end

function git::untracked
    command git ls-files --other --exclude-standard
end

function fish_right_prompt
    set -l jobs_count (jobs -p ^/dev/null | wc -l)

    if test $jobs_count -gt 0
        echo "[$jobs_count] "
    end

    if git::is_repo
        set -l branch (git::branch_name ^/dev/null)
        set -l ref (git show-ref --head --abbrev | awk '{print substr($0,0,7)}' | sed -n 1p)

        if git::is_stashed
            echo -n -s (white)"^"(off)
        end

        if git::is_dirty
            printf (white)"*"(off)
        end

        if command git symbolic-ref HEAD > /dev/null ^/dev/null
            if git::is_staged
                printf (cyan)"$branch"(off)
            else
                printf (yellow)"$branch"(off)
            end
        else
            printf (dim)"$ref"(off)
        end

        for remote in (git remote)
            set -l behind_count (echo (command git rev-list $branch..$remote/$branch ^/dev/null | wc -l | tr -d " "))
            set -l ahead_count (echo (command git rev-list $remote/$branch..$branch ^/dev/null | wc -l | tr -d " "))

            if test $ahead_count -ne 0; or test $behind_count -ne 0; and test (git remote | wc -l) -gt 1
                echo -n -s " "(orange)$remote(off)
            end

            if test $ahead_count -ne 0
                echo -n -s (white)" +"$ahead_count(off)
            end

            if test $behind_count -ne 0
                echo -n -s (white)" -"$behind_count(off)
            end
        end

        echo -n -s (off)
    end

end
