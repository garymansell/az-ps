#Add a Storage Account firewall rule to allow access from a Subnet
# and then update it to also allow access for Azure Services such as Backup etc
$subnet = Get-AzVirtualNetwork -ResourceGroupName "RG01" -Name "VNET01" | Get-AzVirtualNetworkSubnetConfig -Name "VSUBNET01"
Add-AzStorageAccountNetworkRule -ResourceGroupName "RG01" -Name "storage01" -VirtualNetworkResourceId $subnet.Id
Update-AzStorageAccountNetworkRuleSet -ResourceGroupName "RG01" -Name "storage01" -Bypass AzureServices