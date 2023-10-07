
function CheckPort ([int] $port)
{
	Get-Process -Id (Get-NetTCPConnection -LocalPort $port).OwningProcess
}

Invoke-Expression (&starship init powershell)
