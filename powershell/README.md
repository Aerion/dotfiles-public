# Powershell 7

This is crossplatform, but needs Powershell >7 to work.

## Specific set-up for Windows

For Windows, create a file in `$Home\[My ]Documents\PowerShell\Profile.ps1` with the following contents

```powershell
Import-Module "<path-to-this-repo>\dotfiles-public\powershell\.config\powershell\Microsoft.PowerShell_profile.ps1"
```

Make sure that you're using Powershell >7 and not Windows Powershell.