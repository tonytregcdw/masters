#################################################################################################
#
#  Author:  Tony Tregidgo
#
#  Date: Jan 2020
#
#  Purpose: All_Users Tuning
#
#
#################################################################################################
 
#=================================================
#Add the path to the variables and functions.ps1
#=================================================
."C:\Masters\Scripts\Login\Variables.ps1"
."C:\Masters\Scripts\Login\Functions.ps1"

trap {Continue;}

write-host "running all users"


﻿New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name SystemPaneSuggestionsEnabled -Value 0 -PropertyType DWORD -Force
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name SubscribedContent-338388Enabled -Value 0 -PropertyType DWORD -Force
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name SubscribedContent-338389Enabled -Value 0 -PropertyType DWORD -Force
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name SubscribedContent-353696Enabled -Value 0 -PropertyType DWORD -Force
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name SilentInstalledAppsEnabled -Value 0 -PropertyType DWORD -Force

## following disabled, as standard user doesnt have write permissions under HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies
#$RegPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer"
#IF(!(Test-Path $RegPath))
#{
#New-Item -Path $RegPath -Force
#New-ItemProperty -Path $RegPath -Name NoDrives -Value "7" -PropertyType DWORD -Force
#}
#ELSE
#{
#New-ItemProperty -Path $RegPath -Name NoDrives -Value "7" -PropertyType DWORD -Force
#}

# Perform logon tasks for DH Users:
if ($userContext.ismemberof($context, 1, "dh-ug-everyone"))
{
	MapDrive -LocalPath P: -RemotePath "\\dccdc-dh03.derbyhomes.derbyad.net\Public"
	MapDrive -LocalPath T: -RemotePath "\\dccdc-dh03.derbyhomes.derbyad.net\Team"
	#net use P: \\dccdc-dh03.derbyhomes.derbyad.net\Public
	#net use T: \\dccdc-dh03.derbyhomes.derbyad.net\Team
	#New-PSDrive -Name P -PSProvider FileSystem -Root "\\dccdc-dh03.derbyhomes.derbyad.net\Public" -Persist -Scope Global
	#New-PSDrive -Name T -PSProvider FileSystem -Root "\\dccdc-dh03.derbyhomes.derbyad.net\Team" -Persist -Scope Global
}

#//
#//	FOLDER REDIRECTION
#//

#$Dir = Join-Path -Path $strhomedir -childPath "Desktop"
#md $Dir
#reg add "\\HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v "Desktop" /t REG_EXPAND_SZ /d $Dir /f

#$Dir = Join-Path -Path $strhomedir -childPath "Documents"
#md $Dir
#RegWrite "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders", "Personal","EXPANDSTRING", $Dir

#$Dir = Join-Path -Path $strhomedir -childPath "Pictures"
#md $Dir
#RegWrite "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders", "My Pictures", "EXPANDSTRING", $Dir

#$Dir = Join-Path -Path $strhomedir -childPath "Favorites"
#md $Dir
#RegWrite "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders", "Favorites", "EXPANDSTRING", $Dir

#$Dir = Join-Path -Path $strhomedir -childPath "AppData\Roaming"
#ms $Dir
#RegWrite "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders", "AppData", "EXPANDSTRING", $Dir

#$Dir = Join-Path -Path $strhomedir -childPath "AppData\Roaming\Microsoft\Windows\Templates"
#md $Dir
#RegWrite "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders", "Templates", "EXPANDSTRING", $Dir

l_CheckError $Error[0], "Script All_Users - ", 25012, $strUserName
