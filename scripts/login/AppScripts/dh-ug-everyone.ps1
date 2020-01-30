WriteLog -LogFile $strLogFile -Value "Running derby homes script" -Component $strSection -Severity 1

# Perform logon tasks for DH Users:
if ($userContext.ismemberof($context, 1, "dh-ug-everyone"))
{
	MapDrive -LocalPath P: -RemotePath "\\dccdc-dh03.derbyhomes.derbyad.net\Public"
	MapDrive -LocalPath T: -RemotePath "\\dccdc-dh03.derbyhomes.derbyad.net\Team"
}


