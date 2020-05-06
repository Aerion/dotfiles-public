# ~/dotfiles τ cd -                                                *master +21

function fish_prompt
    set -l red "d75f5f"
    set -l cyan "86d8fa"
    set -l symbol "τ "
    set -l code $status

    if set -q fish_private_mode
        echo -n "🕵  "
    end

    if test "$theme_complete_path" = "yes"
        set cwd (prompt_pwd)
    else
        set cwd (basename (prompt_pwd))
    end

    echo -n -s (set_color -o $cyan)"$cwd "(set_color -o normal)

    if test "$code" != 0
        echo -n -s (set_color -o $red)"($code) $symbol"(set_color -o normal)
    else
        printf "$symbol"
    end

end
