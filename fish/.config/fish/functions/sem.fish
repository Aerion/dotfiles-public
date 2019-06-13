function sem
	emacsclient -t -e '(find-file "/sudo::'"$argv[1]"'")'
end
