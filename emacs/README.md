# Setup on Windows

Set HOME: https://github.com/magit/magit/wiki/Pushing-with-Magit-from-Windows

Create `<HOME>\.emacs.d\init.el` and add this:

``` lisp
(setq user-init-file "C:\\<...>\\dotfiles-public\\emacs\\init.el")
(load user-init-file)
```