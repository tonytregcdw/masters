#################################################################################################
#################################################################################################
#
#  Author:  Tony Tregidgo
#
#  Date: Jan 2020
#
#  Purpose: Functions This Script defines functions which can be called by subsequent scripts
#
#
#################################################################################################
 

#=======================================================================================
#
# Function:      enumgroup
#
#
# Purpose:  Outputs a list of all AD groups a user is a member of,  Requires the user
#           distinguished name ($strUserDN) as input
#
# Input: Distinguished name
# output: List of all groups the user is a member of (nested)
#
#=======================================================================================
Function enumgroup([string]$DN)
{
	If ($DN.Equals("")) {write-host 'Usage: Provide user DN as input (e.g. enumgroup $struserdn)'}
	$grouplist = @()
	$myobject = [adsi]("LDAP://$DN")
	$grouplist = $myobject.memberof
	$grouplist
	if ($grouplist.count -gt 0)
	{
		$grouplist | foreach{enumgroup($_)}
	}
}


#=======================================================================================
#
# Function: RegWrite
#
#
# Purpose:  Write Registry Values Not binary yet
#
#=======================================================================================
Function RegWrite ($Path) {
trap {Continue;}
                # Checks for the existance of the RegKey if it's not there creates it and add a value 
                # or adds a value Not Binary Values
                If (!(TEST-PATH $Path[0])) {
                            New-Item -Path $Path[0]
                            Set-ItemProperty -Path $Path[0] -Name $Path[1] -Type $Path[2] -Value $Path[3]}
                Else {
                            Set-ItemProperty -Path $Path[0] -Name $Path[1] -Type $Path[2] -Value $Path[3]
                }
                l_CheckError $Error[0], "Function RegWrite - ", 25005, $strUserName
}
 
#========================================================================================
#
# Function: Reg_DeleteKey
#
# Purpose:  Deletes key and everything in/below it.
#
# 
#========================================================================================
Function Reg_DeleteKey ($Key) {
trap {Continue;}
                    # Checks for the existance of the folder if it's not there Do Nothing 
                    #
                    If (TEST-PATH $Key) {
                    Remove-Item -Path $Key -force -recurse
                    }
                l_CheckError $Error[0], "Function DeleteKey  - ", 25006, $strUserName 
}
 
 
 

#=======================================================================================
#
# Function:      l_HideFolder
#
#
# Purpose:  Sets the hidden attribute on a folder
#
#=======================================================================================
Function l_HideFolder ($FPath) {
trap {Continue;}
                # Checks for the existance of the folder if it's not there Do Nothing 
                #
                If (TEST-PATH $FPath) {
                   Get-Item $FPath -force | %{$_.Attributes = "hidden"}
                   #Get-ChildItem  $FPath -force -recurse | %{$_.Attributes = "hidden"}
                }
                l_CheckError $Error[0], "Function l_HideFolder - ", 25007, $strUserName 
}
 

 
#=======================================================================================
#
# Function:      l_UnHideFolder
#
#
# Purpose:  Sets the Unhidden attribute on a folder
#
#=======================================================================================

Function l_UnHideFolder ($FPath) {
trap {Continue;}
                # Checks for the existance of the folder if it's not there Do Nothing 
                #
                If (TEST-PATH $FPath) {
                   Get-Item $FPath -force | %{$_.Attributes = "Normal"}
                   #Get-ChildItem  $FPath -force -recurse | %{$_.Attributes = "hidden"}
                }
                l_CheckError $Error[0], "Function l_HideFolder - ", 25008, $strUserName 
}
 

#========================================================================================
# Function: l_Subst
#
# Purpose: substs a drive letter to a local path
#
# Inputs: pcDriveLetter - The local drive to subst
#         pcLocalPath - The local path to map
#         pcAction - Connect or Disconnect the drive
#
# Outputs: None
#========================================================================================

Function l_Subst ($pcDriveLetter, $pcLocalPath) {
trap {Continue;}
  # Test for existence of Drive Letter, if not there then Map UNC to it 
                # 
                IF (!(TEST-PATH $pcDriveLetter)) {
      SUBST $pcDriveLetter $pcLocalPath }
                ElseIF ((TEST-PATH $pcDriveLetter)) { 
                   SUBST $pcDriveLetter /D
      SUBST $pcDriveLetter $pcLocalPath }
           l_CheckError $Error[0], "Function i_Subst - ", 25010, $strUserName 
}




#========================================================================================
# Function: l_CheckError
#
# Purpose: Handle All Error and clean up
#
# Inputs: $Err input required 
#              
#
# Outputs: Eventlog entry of the error 
#========================================================================================
Function l_CheckError ($Err) {
          # Test for Errors that have occurred  
                if($Error.Count -gt 0) {$Err1 = $Err[1] + $Err[0] + $Err[3]}
                if($Error.Count -gt 0) {write-eventlog -logname 'Application' -source 'WinLogon' -eventID $Err[2] -entrytype Error -Message $Err1 -category 0  -rawdata 10,20}
                if($Error.Count -gt 0) {$Error.Clear()}
                $Err.cls                                
}

