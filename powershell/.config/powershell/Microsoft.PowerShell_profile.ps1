Function GitStatus { git status --short --branch }
Set-Alias -Name gs -Value GitStatus
Function GitCommitAmend { git commit --amend }
Set-Alias -Name gca -Value GitCommitAmend
Function GitCommitAllAmend { git commit --all --amend }
Set-Alias -Name gcaa -Value GitCommitAllAmend
Function GitAddInteractive { git add --interactive }
Set-Alias -Name gai -Value GitAddInteractive
Function GitAddPatch { git add --patch }
Set-Alias -Name gap -Value GitAddPatch
Function GitPull { git pull }
Set-Alias -Name gpl -Value GitPull
Function GitPush { git push }
Set-Alias -Name gps -Value GitPush -Force
Function GitLog { git log --abbrev-commit }
Set-Alias -Name gl -Value GitLog -Force
Function GitCheckout { git checkout }
Set-Alias -Name gck -Value GitCheckout
Function GitDiff { git diff }
Set-Alias -Name gd -Value GitDiff