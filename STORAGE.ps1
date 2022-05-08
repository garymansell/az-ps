# Create a Storage account
New-AzStorageAccount -Name "SA01" -ResourceGroupName "RG01" -SkuName Standard_GRS -Location "uksouth"

# Get Storage Account Access Keys
Get-AzStorageAccountKey -ResourceGroupName "RG01" -Name "SA01"

# Add a Storage Account firewall rule to allow access from a Subnet
# and then update it to also allow access for Azure Services such as Backup etc
$subnet = Get-AzVirtualNetwork -ResourceGroupName "RG01" -Name "VNET01" | Get-AzVirtualNetworkSubnetConfig -Name "VSUBNET01"
Add-AzStorageAccountNetworkRule -ResourceGroupName "RG01" -Name "storage01" -VirtualNetworkResourceId $subnet.Id
Update-AzStorageAccountNetworkRuleSet -ResourceGroupName "RG01" -Name "storage01" -Bypass AzureServices


# Only allow access to a Storage Account (storage1) Subnet (10.0.1.0/24) from the App Subnet (10.0.0.0/24)
Update-AzStorageAccountNetworkRuleSet -ResourceGroupName "RG1" -Name "storage1" -DefaultAction Deny
Get-AzVirtualNetwork -ResourceGroupName "RG1" -Name "VNet1" | \
    Set-AzVirtualNetworkSubnetConfig -Name "appSubnet" -AddressPrefix "10.0.0.0/24" -ServiceEndpoint "Microsoft.Storage" | \
    Set-AzVirtualNetwork
$subnet = Get-AzVirtualNetwork -ResourceGroupName "RG1" -Name "VNet1" | Get-AzVirtualNetworkSubnetConfig -Name "appSubnet"
Add-AzStorageAccountNetworkRule -ResourceGroupName "RG1" -Name "storage1" -VirtualNetworkResourceId $subnet.Id
