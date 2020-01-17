#=====================================================================================
# Author:    Tony Tregidgo
# Date:      Aug 2012
# Purpose:   Masters logon script module.
#
#=====================================================================================

. $psScriptRoot\Variables.ps1
. $psScriptRoot\Functions.ps1
. $psScriptRoot\DriveMap.ps1
. $psScriptRoot\PrinterMap.ps1
. $psScriptRoot\DDesktop.ps1
. $psScriptRoot\Masters.ps1

$exportedCommands = @( `
    "DDesktop", `
    "DriveMap", `
    "PrinterMap", `
    "enumgroup", `
    "RegWrite", `
    "Reg_DeleteKey", `
    "l_HideFolder", `
    "l_UnHideFolder", `
    "l_CheckError", `
    "WriteLog", `
    "MapDrive", `	
    "Masters" `
)

$exportedVariables = @( `
    "$strUserDN", `
    "$strUserName", `
    "$strMasters", `
    "$UserObj" `
)

# Specify the modules to be exported
Export-ModuleMember -Function $exportedCommands

# Specify the variables to be exported
#Export-ModuleMember -Variable $exportedVariables

# .. or .. export ALL variables
Export-ModuleMember -Variable *

