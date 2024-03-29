#=================================================
#Logon Script
#
#Note: the PSModulePath environment variable must contain the path to the masters.module files
#      e.g. c:\masters\scripts\login\
#=================================================

$error.clear()

#import functions and variables
import-module Masters.Module

$strSection = "Start"
WriteLog -LogFile $strLogFile -Value "Starting script for user: [$strUserName]" -Component $strSection -Severity 1

If ($UserObj.IsInRole("BUILTIN\Administrators")) {Exit}
Else {

#Check Network Connectivity
If (!$strLatency) { WriteLog -LogFile $strLogFile -Value "Warning device is not connected to corporate network]" -Component $strSection -Severity 3 }

#shortcut creation
$strSection = "Desktop and start menu customisation"
Ddesktop

#map network drives
$strSection = "Network Drives"
DriveMap

#run all user script
$strSection = "All Users"
c:\Masters\Scripts\Login\All_Users.ps1

#run app scripts
$strSection = "Application Scripts"
Masters

#map printers
$strSection = "Printer Mapping"
PrinterMap

$strSection = "End"
WriteLog -LogFile $strLogFile -Value "Finished processing script for user: [$strUserName]" -Component $strSection -Severity 1

remove-module Masters.Module

$error.clear()
}


