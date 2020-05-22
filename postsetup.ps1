# This script needs to run after boxstarter was installed, in a new PowerShell session

# Fix Windows Explorer
Set-WindowsExplorerOptions -EnableShowFileExtensions -EnableShowFullPathInTitleBar
 
# Enable the TCP/IP protocol (keep the default value = 1433).
# This port will be used by the webmethods components to connect.
# For more info check: https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/enable-or-disable-a-server-network-protocol?view=sql-server-2017#PowerShellProcedure
Import-Module "sqlps"
$smo = 'Microsoft.SqlServer.Management.Smo.'  
$wmi = new-object ($smo + 'Wmi.ManagedComputer').  

# List the object properties, including the instance names.  
$Wmi  

# Enable the TCP protocol on the default instance.  
$uri = "ManagedComputer[@Name='SAGBASE']/ServerInstance[@Name='MSSQLSERVER']/ServerProtocol[@Name='Tcp']"  
$Tcp = $wmi.GetSmoObject($uri)  
$Tcp.IsEnabled = $true  
$Tcp.Alter()  
$Tcp 

# Restart MSSQLSERVER service to apply the enabled protocol
net stop MSSQLSERVER
net start MSSQLSERVER