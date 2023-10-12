

# src: https://github.com/Raphire/Win11Debloat#click-for-list-of-bloat-that-is-removed
$debloat_url = "https://github.com/Raphire/Win11Debloat/archive/master.zip"
$tempDir = New-Item -ItemType Directory -Path (Join-Path $env:TEMP "dotFiles-debloat_$(Get-Random)")
$zipFilePath = Join-Path $tempDir "content.zip"
$extractedDir = Join-Path $tempDir "_extracted"
$debloatRoot = Join-Path $extractedDir "Win11Debloat-master"
$debloatScript = Join-Path $debloatRoot "Win11Debloat.ps1"
$debloatAppList = Join-Path $debloatRoot "Appslist.txt"
$appList = "app-list.txt"

# src: https://stackoverflow.com/a/2688572
function Write-Color([String[]]$Text, [ConsoleColor[]]$Color) {
    for ($i = 0; $i -lt $Text.Length; $i++) {
        Write-Host $Text[$i] -Foreground $Color[$i] -NoNewLine
    }
    Write-Host
}

Write-Color "Checking for Elevated permissions..." -Color DarkCyan
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Color "WARNING: Please run script with elevated permissions." -Color Red
    Write-Color "See how: ","https://www.thushanfernando.com/posts/2020/windows-terminal-setup/#elevate-powershell-easily" -Color Magenta,Green
    Break
}
else
{
    Write-Color "Script running under elevated permissions..." -Color Green
}

Write-Color "Getting latest Debloat..." -Color DarkCyan
Invoke-WebRequest -Uri $debloat_url -OutFile $zipFilePath
Write-Color "Extracting latest Debloat..." -Color DarkCyan
Expand-Archive -Path $zipFilePath -DestinationPath $extractedDir
Write-Color "Configuring 'AppList'..." -Color DarkCyan
Copy-Item $appList -Destination $debloatAppList -Recurse -force
Write-Color "DEBLOAT: " -Color DarkCyan
Write-Color @"
- RemoveApps
- RemoveGamingApps
- DisableTelemetry
- DisableLockscreenTips
- DisableSuggestions
- HideChat
- ShowSearchIconTb
- TaskbarAlignLeft
- ShowKnownFileExt
- ShowHiddenFolders
"@ -Color Magenta
Write-Color "Press any key to start debloating :-)" -Color Yellow
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
Write-Color "Debloating..." -Color DarkCyan
Invoke-Expression -Command "$debloatScript -Silent -RemoveApps -RemoveGamingApps -DisableTelemetry -DisableLockscreenTips -DisableSuggestions -HideChat -ShowSearchIconTb -TaskbarAlignLeft -ShowKnownFileExt -ShowHiddenFolders"
Write-Color "Cleaning up..." -Color DarkCyan
Remove-Item -Path $tempDir -Recurse -Force
Write-Color "Windows 11 Debloated!" -Color Green
