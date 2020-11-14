function fish_right_prompt
    set -l jobs_count (jobs -p 2>/dev/null | wc -l)

    if test $jobs_count -gt 0
        echo "[$jobs_count] "
    end

    git branch --show-current 2> /dev/null
end
