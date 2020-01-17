#=====================================================================================
# Author:    Tony Tregigdo
# Date:      Jan 2020
# Purpose:   Printer Mapping Script.
#            This script checks the AD groups a user is a member of, maps individual Printers 
#            based on group membership.
#
#=====================================================================================


Function PrinterMap {

	WriteLog -LogFile $strLogFile -Value "Processing printer groups for user: [$strUserDN]" -Component $strSection -Severity 1
	#write-host Printer group prefix: $strGroupPrinterID
	$PrinterPath = "\\dcc-printers.DerbyAD.net\PrintQueue"
	WriteLog -LogFile $strLogFile -Value "Attempting to map printer: [$PrinterPath]" -Component $strSection -Severity 1
	#Map standard printer
	add-printer -connectionname $PrinterPath
	
	#Check for group membership and map Printer according to the description field in AD
#	$StrGroupList | %{ if ($_.Contains($strGroupPrinterID)) 
#		{
#			write-host Printer Group match for: $_
#			$myobject = [adsi]("LDAP://$_")
#			$mapping = $myobject.Description | %{$_.split(",")}
#			add-printer -connectionname "\\" + $mapping[0] + "\" + $mapping[1]
#		}
#	}
}


l_CheckError $Error[0], "Script Printermap - ", 25001, $strUserName
 
