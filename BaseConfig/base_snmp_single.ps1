$Managers = @("rcd-opman.aicollection.local","rcd-infra-mon.aicollection.local")
$ReadOnlyCommunities = @('RcDC0mR3ad$$')
$RWCommunities = @("RcDC0mWr1t3!!")
$sysLocation = "QR"
$sysContact = 'Admin@rcdhotels.com'
$readonlytrap = "R34ad=nlyTr4p"
$rwtrap = "r3adWr1t3Tr4p"

Import-Module ServerManager
        Write-host "Enable ServerManager"
        Import-Module ServerManager
#		#Check if SNMP-Service is already installed
 		Write-host "Checking to see if SNMP is Installed..."
 		$check = Get-WindowsFeature -Name SNMP-Service
#		
		If ($check.Installed -ne "True") {
 			#Install/Enable SNMP-Service
 			Write-host "SNMP is NOT installed..."
 			Write-Host "SNMP Service Installing..."
 			Get-WindowsFeature -name SNMP* | Add-WindowsFeature -IncludeAllSubFeature | Out-Null
 			}
 			Else {
 			Write-Host "Error: SNMP Services Already Installed"
 			}
#Configure SNMP Regigstry Keys
        Write-Host "Setting SNMP sysServices"
        reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\SNMP\Parameters\RFC1156Agent" /v sysServices /t REG_DWORD /d 79 /f | Out-Null
        Write-Host "Setting SNMP sysLocation"
        reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\SNMP\Parameters\RFC1156Agent" /v sysLocation /t REG_SZ /d $sysLocation /f | Out-Null
        Write-Host "Setting SNMP sysContact"
        reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\SNMP\Parameters\RFC1156Agent" /v sysContact /t REG_SZ /d $sysContact /f | Out-Null
        Write-Host "Setting SNMP Community Regkey"
        reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\SNMP\Parameters\TrapConfiguration" /f | Out-Null
        Write-Host "Setting read only SNMP Community Regkey"
        reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\SNMP\Parameters\TrapConfiguration\$readonlytrap" /f | Out-Null
        Write-Host "Setting read write SNMP Community Regkey"
        reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\SNMP\Parameters\TrapConfiguration\$rwtrap" /f | Out-Null
        Write-Host "Adding readonly SNMP Trap Communities"
#Loop Through Read Only SNMP Communities
        Foreach ($ReadOnlyCommunity in $ReadOnlyCommunities) {
            reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\SNMP\Parameters\ValidCommunities" /v $ReadOnlyCommunity /t REG_DWORD /d 4 /f | Out-Null
        }



#Loop Through RW SNMP Communities
        Write-Host "Adding read write SNMP Trap Communities"
        Foreach ($RWCommunity in $RWCommunities) {
            reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\SNMP\Parameters\ValidCommunities" /v $RWCommunity /t REG_DWORD /d 8 /f | Out-Null
        }
#        
#        Write-Host "Creating SNMP Extension Agents RegKey"
#        reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\SNMP\Parameters\ExtensionAgents" /f | Out-Null
#        Write-Host "Creating SNMP SNMP Service Parameters RegKey"
#        reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\SNMP\Parameters" /v NameResolutionRetries /t REG_DWORD /d 10 /f | Out-Null
#        reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\SNMP\Parameters" /v EnableAuthenticationTraps /t REG_DWORD /d 0 /f | Out-Null


#Loop through permitted SNMP management systems
        Write-Host "Adding Permitted Managers"
        $i = 2
        Foreach ($Manager in $Managers){
            reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\SNMP\Parameters\PermittedManagers" /v $i /t REG_SZ /d $manager /f | Out-Null
            reg add ("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\SNMP\Parameters\TrapConfiguration\" + $String) /v $i /t REG_SZ /d $manager /f | Out-Null
            $i++
        }




