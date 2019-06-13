function term_size
         set -l size $argv[1]
         /usr/bin/env echo -ne "\33]50;xft:Fira Code:size=$size\7"
end
