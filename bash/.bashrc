alias em='emacsclient -t'
alias magit="emacsclient -c -t --eval '(let ((display-buffer-alist `((\"^*magit: \" display-buffer-same-window) ,display-buffer-alist))) (magit-status))'"
