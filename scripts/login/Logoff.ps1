#=================================================
#Logon Script
#
#Note: the PSModulePath environment variable must contain the path to the masters.module files
#      e.g. c:\masters\scripts\login\
#=================================================

$error.clear()

#import functions and variables
import-module Masters.Module

If ($UserObj.IsInRole("BUILTIN\account_to_exclude")) {Exit}
Else {



remove-module Masters.Module

$error.clear()
}


