# For running in WSL
## Start daemon on login

_WSL doesn't support systemd for the moment, so we cannot use a service for starting up emacs daemon._

* Create a scheduled task
* Triggers: on logon
* Actions: start a program: `bash`, arguments: `-c "emacs --daemon"`
* Optionally specify where it should be started

# For running in Windows

Set HOME: https://github.com/magit/magit/wiki/Pushing-with-Magit-from-Windows

Create `<HOME>\.emacs.d\init.el` and add this:

``` lisp
(setq user-init-file "C:\\<...>\\dotfiles-public\\emacs\\.emacs.d\\init.el")
(load user-init-file)
```
