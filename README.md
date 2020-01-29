# masters
powershell masters - module version 2.0

Author: Tony Tregidgo - Jan 2020

Run the install-masters.ps1 script to install.

## Manual Installation:

1. copy masters folder and all subdirectories to c:\masters\scripts\login\login.ps1 --> c:\masters\scripts\login

2. Set the environment variable to allow the loading of the custom powershell module:

<code>setx /M PSModulePath "C:\Windows\system32\WindowsPowerShell\v1.0\Modules\;C:\Program Files\Citrix\PowerShell Modules\;c:\masters\scripts\login\</code>

3. Add the login script to the appsetup key:

<code>reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v AppSetup /t REG_SZ /d "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe c:\masters\Scripts\login\logon.ps1,cmstart.exe" /f</code>

4. Set the script execution policy to allow the scripts to run:

<code>%WINDIR%\SysWOW64\Cmd.exe /C C:\Windows\sysnative\WindowsPowerShell\v1.0\powershell.exe Set-ExecutionPolicy RemoteSigned</code>

5. Customise the environment-specific variables in c:\masters\scripts\login\masters.module\variables.ps1 to match the environment.

---
## Usage:

The scripts can either be run by executing:

<code>c:\masters\scripts\login\login.ps1</code>

.. or by running:

<code>import-module masters.module</code>

When importing the module, all of the functions and variables will be directly available from the standard powershell prompt - which can then be used for troubleshooting, and general admin.

---

## STRUCTURE

- c:\masters
  - \scripts
  - \login
    >contains main logon script, and all_users script
    - \appscripts
      >Place any application compatibility scripts in here.  Make the name of the group the same as an AAD or AD group.  The script will be run if the logged on user is a member of that group.  Eg: if a user is a member of the "msteams_users" AD group, name the script "msteams_users.ps1"
    - \masters.module
      >Contains all of the functions and variables that make up the module
    - \shortcuts
      - \startmenu
        >Place any shortcuts you require adding the to the startmenu in here
      - \desktop
        >Place any shortcuts you require adding the to the desktop in here

---
## COMPONENTS

- variables.ps1
  >Contains all of the variables used by the module.  Customise the variables in this file to match your environment.
  >When the module is loaded, all of these variables are available from a powershell prompt, making this a useful admin tool
  
- functions.ps1
  >Contains all of the the functions used by the module.  Under usual circumstances, you probably wont need to edit this file.
  >When the module is loaded, all of these variables are available from a powershell prompt.

- masters.ps1
  >master script to process the groups a user is a member of and then run the required application compatibility scripts, located within the \appscripts foder

- ddesktop.ps1
  >Sets up the dynamic desktop for the logged on user.  Processes groups a user is a member of, and then adds the required startmenu and desktop shortcuts
  
- logon.ps1
  >Main logon script called by the required event.  Eg at logon, or when a user connects to the corporate network (either via a VPN or direct)

---
## EXAMPLES
The following examples can be run from a standard powershell prompt as the logged on user, without needing to run the logon script.  And can serve as a useful tool for troubleshooting and performing admin tasks.

### load the module from a powershell prompt

<code>import-module masters.module</code>

### Display a list of all onprem AD groups the logged user is a member of

<code>$strADgroups</code>

### Display a list of all Azure AD groups the logged user is a member of

<code>$strAADgroups</code>

### Display the latency of the network connection (if connected to a network hosting an onprem AD)

<code>$strlatency</code>

### Run the mapdrives function.

<code>mapdrives</code>

  
