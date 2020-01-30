#################################################################################################
#
#  Author:  Tony Tregidgo
#
#  Date: Jan 2020
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
	$removelist = @(
	"Programs\Admin Tools",
	"Programs\Administrative Tools",
	"Programs\System Tools\Command Prompt.lnk",
	"Programs\System Tools\Administrative Tools.lnk",
	"Programs\Windows PowerShell"
	)
	WriteLog -LogFile $strLogFile -Value "DDesktop - processing shortcuts" -Component $strSection -Severity 1
	#copy shortcuts to start menu
	copy-item $strShortcuts\*.* $StrStartMenu -recurse -force -ErrorAction SilentlyContinue

	#Remove shortcuts as required if they exist
	$removelist | %{ if(test-path -Path $StrStartMenu\$_ -ErrorAction SilentlyContinue)
		{
			WriteLog -LogFile $strLogFile -Value "Removing [$StrStartMenu\$_]" -Component $strSection -Severity 1
			#Delete the existing start menu item
			remove-item $StrStartMenu\$_ -recurse -force -ErrorAction SilentlyContinue
		}
	}
}

l_CheckError $Error[0], "Script DDesktop - ", 25001, $strUserName
 


