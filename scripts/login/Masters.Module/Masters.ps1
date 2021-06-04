#=====================================================================================
# Author:    Tony Tregidgo
# Date:      Jan 2020
# Purpose:   Masters logon script.
#            This script checks the AD groups a user is a member of, and then runs 
#            individual logon scripts based on group membership.
#            All Application Compatibility scripts must be named the same as the 
#            group who needs to run them.  E.G. if you are a member of CTX_Users 
#            then you will run the CTX_Users.ps1 script
#            $strGroupID within the variables file needs to be defined to identify users and application 
#            compatability scripts, eg (CTX_)
#
#=====================================================================================

WriteLog -LogFile $strLogFile -Value "running masters for user: [$strUserDN]" -Component $strSection -Severity 1

Function Masters {
	#Declare Variables
	$AppScriptList = @()
	#Search for application compatability scripts
	$AppScriptList = Get-ChildItem -include ''$strAppScript*.ps1'' -name
	
	WriteLog -LogFile $strLogFile -Value "processing the app scripts:" -Component $strSection -Severity 1

	#Check for group membership and run scripts
#	$AppScriptList | %{ if ($UserObj.IsInRole($StrDomainName+"\"+($_.replace(".ps1", "")))) 
	$AppScriptList | %{ if ($userContext.ismemberof($context, 1, $_.replace(".ps1", "")))
		{
			WriteLog -LogFile $strLogFile -Value "group match, running appscript: [$strAppScript\$_]" -Component $strSection -Severity 1
			&$strAppScript\$_
		}
	}
}

l_CheckError $Error[0], "Script Masters - ", 25001, $strUserName


