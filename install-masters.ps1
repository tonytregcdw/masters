#powershell masters installation scripts
###############################################################################################
####note: to sign the scripts, the following commands need to be run from a machine with the signing .pfx locally installed as an admin:
####$cert = Get-ChildItem -Path cert:\CurrentUser\my -CodeSigningCert
####get-childitem -recurse *.ps*1 | %{Set-AuthenticodeSignature $_ -Certificate $cert}
###############################################################################################

#Install trusted publisher certificate
#Import-Certificate -FilePath .\DCC-PS1.cer -CertStoreLocation Cert:\LocalMachine\TrustedPublisher

#Install Microsoft trusted publisher certificate
#Import-Certificate -FilePath .\Microsoft_Corporation.cer -CertStoreLocation Cert:\LocalMachine\TrustedPublisher

#Set the execution policy
#set-executionpolicy -Scope LocalMachine -ExecutionPolicy AllSigned -force

#set the env variable to allow the module to be imported.
setx /M PSModulePath "C:\Program Files\WindowsPowerShell\Modules;C:\Windows\system32\WindowsPowerShell\v1.0\Modules\;c:\masters\scripts\login"

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


#create folder structure
new-item -ItemType "directory" -Path "c:\masters"

#copy scripts
copy-item -Path "${PSScriptRoot}\scripts" -Destination "c:\masters" -recurse -Force

#import scheduled task to trigger logon script when VPN network is detected.
register-scheduledtask -Xml (get-content '.\masterstrigger.xml' | out-string) -taskname "masterslogon"





