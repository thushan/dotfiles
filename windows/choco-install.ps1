<#
   Installs the choco.packages ignoring any comments
   marked with a # at the start of the line.
#>
$filename = 'choco.packages'

# src: https://stackoverflow.com/a/2688572
function Write-Color([String[]]$Text, [ConsoleColor[]]$Color) {    
    for ($i = 0; $i -lt $Text.Length; $i++) {
        Write-Host $Text[$i] -Foreground $Color[$i] -NoNewLine
    }
    Write-Host
}

# Iterates through the file and install or upgrade the silently.

(Get-Content $filename) -notmatch '^#'  -match "\S" `
| ForEach-Object { 
    Write-Color -Text "Installing ", $_, '...' -Color DarkCyan,Magenta,DarkCyan
    choco upgrade -y $_ 
    if( $? ){
        Write-Color -Text "Installing ", $_, "...", "Success :)" -Color DarkCyan,Magenta,DarkCyan,Green
    }
    if( !$? ){
        Write-Color -Text "Installing ", $_, "...", "Failed :(" -Color DarkCyan,Magenta,DarkCyan,Red
    }
    
}
