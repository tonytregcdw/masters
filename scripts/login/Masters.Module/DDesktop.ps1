#################################################################################################
#
#  Author:  Tony Tregidgo - HP ESS
#
#  Date: Jan 2012
#
#  Purpose: DDesktop Builds a User's Dynamic Desktop environment
#
# 
#################################################################################################

#=================================================
#Add the path to the variables and functions.ps1
#=================================================
 
trap {Continue;}
 
Function DDesktop {
	#Get list of shortcut folders
	$ShortcutFolderList = Get-ChildItem $StrShortcuts -name -exclude *.*
	
	#Get start menu location
	$dpath = [Environment]::GetFolderPath("StartMenu")
	
	#Delete the existing start menu 
	get-childitem $dpath | remove-item -recurse -force -ErrorAction SilentlyContinue
	
	#Loop through shortcut folder groups and copy shortcuts if group match
	$ShortcutFolderList | %{if ($UserObj.IsInRole($StrDomainName+"\"+($_))) { 
	   IF (TEST-PATH $dpath) {
	    Get-ChildItem $StrShortcuts"\.\$_" | Copy-Item -destination $dpath -recurse -ErrorAction SilentlyContinue} }}
}

l_CheckError $Error[0], "Script DDesktop - ", 25001, $strUserName
 
