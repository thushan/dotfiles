<#
   Installs the choco.packages ignoring any comments
   marked with a # at the start of the line.
#>
param(
    [string]
	$filename = "choco-base.packages"
)

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

Write-Color "Checking Choco installed..." -Color DarkCyan
if (-Not (Test-Path $env:ChocolateyInstall\bin\choco.exe)) {
	Write-Color "Installing Choco..." -Color Red
    Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1')
} else {
	Write-Color "Choco installed already!" -Color Green
}

# Iterates through the file and install or upgrade the silently.
$install_totald = 0
$install_succes = 0
$install_failed = 0

(Get-Content $filename) -notmatch '^#'  -match "\S" `
| ForEach-Object {
    Write-Color -Text "Installing ", $_, '...' -Color DarkCyan,Magenta,DarkCyan
    $install_totald++
    choco upgrade -y $_
    if( $? ){
        Write-Color -Text "Installing ", $_, "...", "Success :)" -Color DarkCyan,Magenta,DarkCyan,Green
        $install_succes++
    }
    if( !$? ){
        Write-Color -Text "Installing ", $_, "...", "Failed :(" -Color DarkCyan,Magenta,DarkCyan,Red
        $install_failed++
    }
}

Write-Color "Completed installing (", $install_totald , ") packages with (", $install_succes, ") succesful, (",  $install_failed, ") failures."  -Color DarkCyan,Magenta,DarkCyan,Green,DarkCyan,Red,DarkCyan
