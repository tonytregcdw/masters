#powershell masters installation scripts

#clean up previous installation

if (get-scheduledtask | where { $_.TaskName -eq "masterslogon" })
{
	Unregister-ScheduledTask -TaskName "masterslogon" -Confirm:$false
	write-host "removed scheduled task"
}
if (test-path "c:\masters")
{
	Remove-Item -Recurse -Force c:\masters
	write-host "removed masters folder"
}

write-host "complete"



