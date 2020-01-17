# masters
powershell masters
powershell masters - module version 2.0
Author: Tony Tregidgo - Aug 2020

Run the install-masters.ps1 script to install.

Manual Installation:

1. masters folder and all subdirectories to c:\masters\scripts\login\
login.ps1 --> c:\masters\scripts\login

2. Set the environment variable to allow the loading of the custom powershell module:
setx /M PSModulePath "C:\Windows\system32\WindowsPowerShell\v1.0\Modules\;C:\Program Files\Citrix\PowerShell Modules\;c:\masters\scripts\login\

3. Add the login script to the appsetup key:
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v AppSetup /t REG_SZ /d "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe c:\masters\Scripts\login\logon.ps1,cmstart.exe" /f

4. Set the script execution policy to allow the scripts to run:
%WINDIR%\SysWOW64\Cmd.exe /C C:\Windows\sysnative\WindowsPowerShell\v1.0\powershell.exe Set-ExecutionPolicy RemoteSigned

5. Customise the environment-specific variables in c:\masters\scripts\login\masters.module\variables.ps1
If necessary, to match the environment

Usage:

The scripts can either be run by executing:

c:\masters\script\login\login.ps1

.. or by running:

import-module masters.module

When importing the module, all of the functions and variables will be directly available from the standard powershell prompt - which can then be used for troubleshooting, and general admin.



