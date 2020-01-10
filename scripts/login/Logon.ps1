#=================================================
#HP ESS Citrix Logon Script
#
#Note: the PSModulePath environment variable must contain the path to the masters.module files
#      e.g. c:\masters\scripts\login\
#=================================================

$error.clear()

#import functions and variables
import-module Masters.Module

If ($UserObj.IsInRole("BUILTIN\account_to_exclude")) {Exit}
Else {

#shortcut creation
#Ddesktop

#map network drives
DriveMap

#run all user script
c:\Masters\Scripts\Login\All_Users.ps1

#run app scripts
Masters

remove-module Masters.Module

$error.clear()
}
