<#
   Installs the choco.packages ignoring any comments
   marked with a # at the start of the line.
#>
param(
    [string]
	$filename = "scoop.packages"
)

# src: https://stackoverflow.com/a/2688572
function Write-Color([String[]]$Text, [ConsoleColor[]]$Color) {
    for ($i = 0; $i -lt $Text.Length; $i++) {
        Write-Host $Text[$i] -Foreground $Color[$i] -NoNewLine
    }
    Write-Host
}

Write-Color "Checking Scoop installed..." -Color DarkCyan
# Check if Scoop is installed, if not, install it
if (-Not (Test-Path $env:USERPROFILE\scoop)) {
	Write-Color "Installing Scoop..." -Color Red
    Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
} else {
	Write-Color "Scoop installed already!" -Color Green
}

# Iterates through the file and install or upgrade the silently.
$install_totald = 0
$install_succes = 0
$install_failed = 0

(Get-Content $filename) -notmatch '^#'  -match "\S" `
| ForEach-Object {
    Write-Color -Text "Installing ", $_, '...' -Color DarkCyan,Magenta,DarkCyan
    $install_totald++
    scoop install $_
    if( $? ){
        Write-Color -Text "Installing ", $_, "...", "Success :)" -Color DarkCyan,Magenta,DarkCyan,Green
        $install_succes++
    }
    if( !$? ){
        Write-Color -Text "Installing ", $_, "...", "Failed :(" -Color DarkCyan,Magenta,DarkCyan,Red
        $install_failed++
    }
}

Write-Color "Completed Scoop'ing (", $install_totald , ") packages with (", $install_succes, ") succesful, (",  $install_failed, ") failures."  -Color DarkCyan,Magenta,DarkCyan,Green,DarkCyan,Red,DarkCyan
