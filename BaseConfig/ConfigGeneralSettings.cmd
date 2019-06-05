@echo off
REM ScriptFrameWork by Joe Shonk - www.theshonkproject.com

pushd %~dp0

cmd /c net user Administrator /active:yes
cmd /c reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v FilterAdministratorToken /t REG_DWORD /d 0 /f
cmd /c reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v EnableFirstLogonAnimation /d 0 /t REG_DWORD /f
cmd /c reg add "HKLM\SOFTWARE\Microsoft\ServerManager" /v "DoNotOpenServerManagerAtLogon" /d 1 /t REG_DWORD /f
cmd /c reg add "HKLM\SOFTWARE\Microsoft\ServerManager\oobe" /v "DoNotOpenInitialConfigurationTasksAtLogon" /d 1 /t REG_DWORD /f
cmd /c powercfg -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
cmd /c powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c fea3413e-7e05-4911-9a71-700331f1c294 0e796bdb-100d-47d6-a2d5-f7d2daa51f51 0
cmd /c powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 238c9fa8-0aad-41ed-83f4-97be242c8f20 29f6c1db-86da-48c5-9fdb-f2b67b1f44da 0
cmd /c powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 7516b95f-f776-4464-8c53-06167f40cc99 3c0bc021-c8a8-4e07-a973-6b14cbcb2b7e 0
cmd /c winrm quickconfig -quiet
cmd /c winrm quickconfig -quiet -force
cmd /c reg add HKLM\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell /v ExecutionPolicy /t REG_SZ /d Unrestricted /f
cmd /c reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\policies\system /v EnableLUA /t REG_DWORD /d 0 /f
cmd /c netsh advfirewall Firewall set rule group="Remote Desktop" new enable=yes
cmd /c diskperf -y
