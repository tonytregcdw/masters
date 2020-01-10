#=====================================================================================
# Author:    Tony Tregidgo
# Date:      Jan 2020
# Purpose:   Masters logon script.
#            This script checks the AD groups a user is a member of, and then runs 
#            individual logon scripts based on group membership.
#            All Application Compatibility scripts must be named the same as the 
#            group who needs to run them.  E.G. if you are a member of CTX_Users 
#            then you will run the CTX_Users.ps1 script
#            $strGroupID needs to be defined to identify users and application 
#            compatability scripts, eg (CTX_)
#
#=====================================================================================

echo "running masters"

Function Masters {
	#Declare Variables
	$AppGroupList = @()
	$AppScriptList = @()
	echo "running masters"
	#Search for application compatability scripts
	$AppScriptList = Get-ChildItem -include ''$strAppScript$strGroupID*.ps1'' -name
	
	echo "processing the following app scripts:"
	echo $appscriptlist
	#Check for group membership and run scripts
#	$AppScriptList | %{ if ($UserObj.IsInRole($StrDomainName+"\"+($_.replace(".ps1", "")))) 
	$AppScriptList | %{ if ($userContext.ismemberof($context, 1, $_.replace(".ps1", "")))
		{
			echo "Group match, running script:"
			&$strAppScript\$_
		}
	}
}

l_CheckError $Error[0], "Script Masters - ", 25001, $strUserName
