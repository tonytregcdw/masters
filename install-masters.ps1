#powershell masters installation scripts

#set the env variable to allow the module to be imported.
setx /M PSModulePath "C:\Program Files\WindowsPowerShell\Modules;C:\Windows\system32\WindowsPowerShell\v1.0\Modules\;c:\masters\scripts\login"

#clean up previous installation
Unregister-ScheduledTask -TaskName "masterslogon" -Confirm:$false
Remove-Item -Recurse -Force c:\masters

#create folder structure
new-item -ItemType "directory" -Path "c:\masters"

#copy scripts
copy-item -Path "${PSScriptRoot}\scripts" -Destination "c:\masters" -recurse -Force

#import scheduled task
register-scheduledtask -Xml (get-content '.\masterstrigger.xml' | out-string) -taskname "masterslogon"
