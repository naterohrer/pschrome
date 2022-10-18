#Get Stable Chrome Version for Windows
$url = 'https://omahaproxy.appspot.com/win'
$versioning = Invoke-WebRequest -URI $url
#Write-Host $versioning

#Get remote machine Chrome version
$machines = Get-content -Path machines.txt
ForEach($machine in $machines){
$Version = Invoke-command -computer $machine {(Get-Item (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe').'(Default)').VersionInfo}

#compare machien version with Current stable
"$machine - $Version"
if ($machine -eq $versioning){
	Write-Host "$machine is up to date Version - $machine"
}else{
	Invoke-Command -ComputerName $machine -Scriptblock {"C:\Program Files (x86)\Google\Update\GoogleUpdate.exe /c"}
}
