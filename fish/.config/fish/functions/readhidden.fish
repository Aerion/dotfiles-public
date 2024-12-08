# Defined in - @ line 0
function readhidden --description 'alias readhidden read -i HIDDEN; echo -n "$HIDDEN" | xib; set HIDDEN ""'
	read -s HIDDEN; echo -n "$HIDDEN" | xib; set HIDDEN "" $argv;
end
