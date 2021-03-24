Set-PSReadLineOption -EditMode Emacs

Function GitStatus { git status --short --branch $args }
Set-Alias -Name gs -Value GitStatus
Function GitCommitAmend { git commit --amend $args }
Set-Alias -Name gca -Value GitCommitAmend
Function GitCommitAllAmend { git commit --all --amend $args }
Set-Alias -Name gcaa -Value GitCommitAllAmend
Function GitAddInteractive { git add --interactive $args }
Set-Alias -Name gai -Value GitAddInteractive
Function GitAddPatch { git add --patch $args }
Set-Alias -Name gap -Value GitAddPatch
Function GitPull { git pull $args }
Set-Alias -Name gpl -Value GitPull
Function GitPush { git push $args }
Set-Alias -Name gps -Value GitPush -Force
Function GitLog { git log --abbrev-commit $args }
Set-Alias -Name gl -Value GitLog -Force
Function GitCheckout { git checkout $args }
Set-Alias -Name gck -Value GitCheckout
Function GitSwitch { git switch $args }
Set-Alias -Name gsw -Value GitSwitch
Function GitDiff { git diff $args }
Set-Alias -Name gd -Value GitDiff

function abbrev($str, $sep, $min_count) {
    $params = "$str" -split [Regex]::Escape("$sep")

    if ($params.length -lt $min_count) {
        return $str
    }

    $paramsInitials = $params[0..($params.length - 2)] | % { [string]$_[0] }
    $res = Join-String -Separator $sep -InputObject $paramsInitials
    $res += "${sep}" + ${params}[-1]

    return $res
}

# /abc/def/ghi/folder/again => /a/d/g/f/again
# /abc => /abc
function prompt_get_cwd {
    $cwd = (Get-Location).Path
    $sep = [IO.Path]::DirectorySeparatorChar.ToString()
    return abbrev "$cwd" "$sep" 3
}

function prompt {
    $success = $?
    $red = "DarkRed"
    $cyan = "DarkCyan"
    $symbol = "τ"

    # Set bold (`e[21m to unset)
    Write-Host "`e[1m" -NoNewLine -ForegroundColor $cyan

    $cwd = prompt_get_cwd
    Write-Host "$cwd " -NoNewLine -ForegroundColor $cyan

    if (!$success) {
        Write-Host "❌ $symbol`e[0m" -NoNewLine -ForegroundColor $red
    } else {
        Write-Host "`e[0m$symbol" -NoNewLine
    }

    # TODO: make it appear at the end of the line
    $branch = git branch --show-current 2> /dev/null
    if ($?) {
        $abbrev_branch = abbrev "$branch" "/" 2
        Write-Host " ($abbrev_branch)" -NoNewLine
    }

    return " "
}