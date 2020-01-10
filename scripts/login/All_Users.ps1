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

#Auto End Tasks
RegWrite "hkcu:\Control Panel\Desktop", "AutoEndTasks", "String", "1"
RegWrite "hkcu:\Control Panel\Desktop", "WaittoKillAppTimeout", "String", "20000"

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
