[CmdletBinding()]
param(
    [Parameter()]
    [switch]$ShowUI
)

if ($IsLinux -or $IsOSX) { 
    Write-Error "This script is currently supported only for Windows!"
    return
}

[string]$URI = "https://atom.io/download/windows_x64"
[string]$FileName = "AtomSetup-x64.exe"

[string]$filePath = (Join-Path $env:TEMP $FileName)

try {
    $ProgressPreference = 'SilentlyContinue'

    Write-Host "`nDownloading $FileName..."

    Remove-Item -Force $filePath -ErrorAction SilentlyContinue
    Invoke-Webrequest -Uri $downloadUrl -OutFile $filePath

    Write-Host "`nInstalling Atom..."
    if ($ShowUI) {
        Start-Process $filePath -Wait
    }
    else {
        Start-Process $filePath -ArgumentList "--silent" -Wait
    }
}
finally {
    $ProgressPreference = 'Continue'
}
