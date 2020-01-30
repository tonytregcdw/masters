#egress client app script

WriteLog -LogFile $strLogFile -Value "running agress client app script" -Component $strSection -Severity 1

New-ItemProperty -Path "HKCU:\Software\Microsoft\Office\Outlook\Addins\Egress.Sdx.Workspace.Office" -Name LoadBehavior -Value 3 -PropertyType DWORD -Force

