# Dotfiles

All my user config is stored in this repository.

## How to use it?

### Under Linux

* Install [stow](https://www.gnu.org/software/stow/)
* Clone this repository
* `cd dotfiles-public`
* `stow <project>` where `project` is one of the folders (use `stow -d <project>` to revert)

Example with fish configuration:
```
$ ls -ld ~/.config/fish
ls: cannot access '/home/username/.config/fish': No such file or directory
$ stow fish
$ ls -ld ~/.config/fish
lrwxrwxrwx 1 username username 36 Apr 21 21:28 /home/username/.config/fish -> ../dotfiles-public/fish/.config/fish
```

### Under Windows

The majority of these configs are specific to Linux. But some are applicable to
Windows. For these, indications should be available in a nested README.
For instance, for Alacritty or Emacs, README ([alacritty](https://github.com/Aerion/dotfiles-public/tree/master/alacritty), [emacs](https://github.com/Aerion/dotfiles-public/tree/master/emacs)) describe
how to use the configuration for Windows / WSL.
