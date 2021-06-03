WriteLog -LogFile $strLogFile -Value "Running derby homes script" -Component $strSection -Severity 1

# Perform logon tasks for members of dh-ug-everyone group:
if ($userContext.ismemberof($context, 1, "dh-ug-everyone"))
{
	MapDrive -LocalPath P: -RemotePath "\\fileshare\Public"
	MapDrive -LocalPath T: -RemotePath "\\fileshare\Team"
}


