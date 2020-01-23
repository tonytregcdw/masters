masters module intune packaging and deployment guide

-- wrapping --

For deployment via the intune service, it is necessary to wrap the installation source files as an .intunewin file.

The following syntax can be used from a powershell prompt to package the scripts:

.\IntuneWinAppUtil.exe -c .\masters_source\ -s .\masters_source\install-masters.ps1 -o .

Note: In this example the "masters_source" folder is a subfolder of the folder where "intunewinapputil.exe" resides.


-- deployment --

Once the install-masters.intunewin file has been created, it can then be uploaded to intune.  We recommend you increment the version number each time this is uploaded. (eg rename file to "install-masters-v10.intunewin")

