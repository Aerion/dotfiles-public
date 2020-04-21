# For Windows

## Use this config

* Install Alacritty (`choco install -y alacritty`)
* Create folder Alacritty in %Appdata%
* Copy `alacritty.yml` to %Appdata%\Alacritty

## Start WSL directly in Alacritty

* Create a shortcut to Alacritty
* Specify args to `-t wsl` so that the shortcut target is `"C:\Program Files\Alacritty\alacritty.exe" -e wsl`
