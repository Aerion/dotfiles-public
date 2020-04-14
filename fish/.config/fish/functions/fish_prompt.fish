# ~/dotfiles τ cd -                                                *master +21

function fish_prompt
    set -l symbol "τ "
    set -l code $status

    if set -q fish_private_mode
        printf "🕵  "
    end

    if test "$theme_complete_path" = "yes"
        set cwd (prompt_pwd)
    else
        set cwd (basename (prompt_pwd))

        if git::is_repo
            set root_folder (command git rev-parse --show-toplevel ^/dev/null)
            set parent_root_folder (dirname $root_folder)
            set cwd (echo $PWD | sed -e "s|$parent_root_folder/||")
        end
    end

    printf (cyan)"$cwd "(off)

    if test "$code" != 0
        echo -n -s (red)"($code) $symbol"(off)
    else
        printf "$symbol"
    end

end
