#=====================================================================================
# Author:    Tony Tregigdo
# Date:      Jan 2020
# Purpose:   Drive Mapping Script.
#            This script checks the AD groups a user is a member of, maps individual drives 
#            based on group membership.
#
#=====================================================================================


Function DriveMap {
	$file="\\dcc-citrix-stor\drivemappings$\"+$strUserName+".txt"
	$Mappings = Get-Content $file

	ForEach ($Drive in $Mappings) 
		{
		$Letter,$Mapping = $Drive.split(':')
		MapDrive -LocalPath $Letter`: -RemotePath $Mapping
#		Try{
#			Remove-SmbMapping -LocalPath $Letter`: -Force -UpdateProfile -Confirm:$false
#			WriteLog -LogFile $strLogFile -Value "Force removed: [$Letter]" -Component $strSection -Severity 1
#		} Catch {
#			WriteLog -LogFile $strLogFile -Value "Error removing: [$Letter]]. $_" -Component $strSection -Severity 1
#		}
#
#		Try{
#			New-SmbMapping -LocalPath $Letter`: -RemotePath $Mapping -Persistent:$true
#			$return = $true
#		} Catch {
#			WriteLog -LogFile $strLogFile -Value "Error mapping drive [$Letter] to: [$RemotePath]. $_" -Component $strSection -Severity 3
#		}
	}
}



#Function DriveMap {
#
#	#Declare Variables
#	$DriveGroupList = @()
#	
#	write-host Processing drive groups for user: $strUserDN
#	
#	#Get user group list
#	$DriveGroupList = enumgroup($strUserDN)
#	
#	write-host drive group prefix: $strGroupDriveID
#	
#	#Check for group membership and map drive according to the description field in AD
#	$DriveGroupList | %{ if ($_.Contains($strGroupDriveID)) 
#		{
#			write-host Drive Group match for: $_
#			$myobject = [adsi]("LDAP://$_")
#			$mapping = $myobject.Description | %{$_.split(",")}
#			#New-PSDrive -name $mapping[0] -psprovider FileSystem -root $mapping[1]
#			net use $mapping[0] $mapping[1]
#		}
#	}
#}


l_CheckError $Error[0], "Script Drivemap - ", 25001, $strUserName
 
