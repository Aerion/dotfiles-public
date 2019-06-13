# Defined in - @ line 0
function readhidden --description 'alias readhidden read -i HIDDEN; echo -n "$HIDDEN" | xsel -i -b; set HIDDEN ""'
	read -s HIDDEN; echo -n "$HIDDEN" | xsel -i -b; set HIDDEN "" $argv;
end
