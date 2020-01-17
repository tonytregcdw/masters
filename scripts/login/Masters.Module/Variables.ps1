#################################################################################################
#
#  Author:  Tony Tregidgo
#
#  Date: Jan 2020
#
#  Purpose: Central Variable definitions for the masters logon scripts
#
#
#################################################################################################

trap {Continue;}

#################################################################################################
#
#  Environment variables - set depending on the specific environment
#
#################################################################################################


# Set the section of the script being processed
$strSection = "init"

# Set the location of the Masters directory
$strMasters = "C:\Masters\" 
 
#Location of Dynamic Desktop Shortcuts
$strShortcuts = "C:\Masters\Admin\Shortcuts\"
 
#Location of Desktop Shortcuts
$strDesktopShortcuts = "C:\Masters\Admin\Desktop\"
 
#Location of Application Compatibility Scripts
$strAppScript = "C:\Masters\Scripts\Login\"
 
#Citrix group identifier prefix (eg. CTX_)
$strGroupID = "SEC_"

#Drive mapping group prefix
$strGroupDriveID = "DRV_"

#Log File Info
$strLogPath = "$env:Temp"
$strLogName = "masters-Login-Script.log"
$strLogFile = Join-Path -Path $strLogPath -ChildPath $strLogName


#################################################################################################
#
#  System variables
#
#################################################################################################

#Get the Users Application data path from the environs
$strAppdata = [Environment]::GetFolderPath("ApplicationData")

#Get the Users HomePath from the environs
$strHomePath = get-content env:HomePath
 
#Get the Users HomePath from the environs
$strHomeDrive = get-content env:Homedrive

#Join the Path to create the Home dir 
$strHomeDir  = Join-Path -Path $strHomeDrive -ChildPath $strHomePath
 
#Get the System Root Folder
$strSystemRoot = get-content env:SystemRoot
 
#Get the domain Name 
$strDomainName = get-content env:UserDomain
 
#Get User Profile Path
$strUserProfile = get-content env:USERPROFILE
 
#Get the Logon Server Name
$strLogonServer = get-content env:LogonServer
 
#Get the Username 
$strUserName = get-content env:UserName

#Get the DNS name of the AD domain
$strDNSDomainName = $env:USERDNSDOMAIN

Add-Type -AssemblyName System.DirectoryServices.AccountManagement
$context = New-Object System.DirectoryServices.AccountManagement.PrincipalContext([System.DirectoryServices.AccountManagement.ContextType]::Domain, $strDNSDomainName)

$userContext = [System.DirectoryServices.AccountManagement.UserPrincipal]::FindByIdentity($context, $strUserName);

#Get the LDAP user object
#$strFilter = "(&(objectCategory=User)(samAccountName=$strUserName))"
#$objSearcher = New-Object System.DirectoryServices.DirectorySearcher
#$objSearcher.Filter = $strFilter
#$objPath = $objSearcher.FindOne()
#$UserObject = $objPath.GetDirectoryEntry()

#Get the NT user object
$UserObj = (new-object System.Security.Principal.WindowsPrincipal([System.Security.Principal.WindowsIdentity]::GetCurrent()))

#Get the user distinguished name
$strUserDN = $userContext.DistinguishedName

#Get list of user groups
$strGroupList = $userContext.GetGroups() | Select-Object Name  | Where-Object {!($_.psiscontainer)} | foreach {$_.Name}

#Get connection latency
$strLatency = Test-Connection -computername $strDNSDomainName -Count 1 | Select-Object responsetime  | Where-Object {!($_.psiscontainer)} | foreach {$_.responsetime}
