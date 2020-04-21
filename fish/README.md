## Install fisher

Fisher is the fish package manager used in this config.
Packages used are in specified in fishfile.

To install fisher and download the packages specified in fishfile, run the following:

```
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end
```
[source](https://github.com/jorgebucaran/fisher)