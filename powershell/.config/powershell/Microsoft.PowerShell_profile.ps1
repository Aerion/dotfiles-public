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

# /abc/def/ghi/folder/again => /a/d/g/f/again
# /abc => /abc
function prompt_get_cwd {
    $cwd = (Get-Location).Path
    $sep = [IO.Path]::DirectorySeparatorChar.ToString()
    $params = "$cwd" -split $sep

    if ($params.length -lt 3) {
        return $cwd
    }

    $paramsInitials = $params[0..($params.length - 2)] | % { [string]$_[0] }
    $res = Join-String -Separator $sep -InputObject $paramsInitials
    $res += "${sep}" + ${params}[-1]

    return $res
}

function prompt {
    $red = "DarkRed"
    $cyan = "DarkCyan"
    $symbol = "τ"
    $code = $LASTEXITCODE

    # Set bold (`e[21m to unset)
    Write-Host "`e[1m" -NoNewLine -ForegroundColor $cyan

    $cwd = prompt_get_cwd
    Write-Host "$cwd " -NoNewLine -ForegroundColor $cyan

    if ($code ?? 0 -ne 0) {
        Write-Host "($code) $symbol`e[21m" -NoNewLine -ForegroundColor $red
    } else {
        Write-Host "`e[21m$symbol" -NoNewLine
    }

    # TODO: make it appear at the end of the line
    $branch = git branch --show-current 2> /dev/null
    if ($LASTEXITCODE -eq 0) {
        Write-Host " ($branch)" -NoNewLine
    }

    return " "
}