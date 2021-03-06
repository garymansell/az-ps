#Delete vNET
Get-AzVirtualNetwork -ResourceGroup $vm.ResourceGroupName | Remove-AzVirtualNetwork -Force

#Delete NSG
Get-AzNetworkSecurityGroup -ResourceGroup $vm.ResourceGroupName | Remove-AzNetworkSecurityGroup -Force

#Delete Public IP
Get-AzPublicIpAddress -ResourceGroup $vm.ResourceGroupName | Remove-AzPublicIpAddress -Force

#Create a Subnet on an existing VNET with a Service Endpoint connection to Microsoft Storage
Get-AzVirtualNetwork -ResourceGroupName "RG01" -Name "VNET01" | `
Set-AzVirtualNetworkSubnetConfig -Name "VSUBNET01" -AddressPrefix "10.0.0.0/24" -ServiceEndpoint "Microsoft.Storage" | `
Set-AzVirtualNetwork

# Create NSG with rules for HTTP and RDP
$rule1 = New-AzNetworkSecurityRuleConfig -Name "RDP" -Description "Allow RDP" -Access Allow -Protocol Tcp -Direction Inbound -Priority 100 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 3389
$rule2 = New-AzNetworkSecurityRuleConfig -Name "HTTP" -Description "Allow HTTP" -Access Allow -Protocol Tcp -Direction Inbound -Priority 101 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 80
$nsg = New-AzNetworkSecurityGroup -ResourceGroupName "Gary-Admin-RG" -Location uksouth -Name "NSG-Frontend" -SecurityRules $rule1,$rule2

#Azure Private DNS Zone & Link
$zone = New-AzPrivateDnsZone -Name 'private.ps.com' `
-ResourceGroupName 'pluralsight-rg'

$link = New-AzPrivateDnsVirtualNetworkLink -ZoneName 'private.ps.com' `
-ResourceGroupName 'pluralsight-rg' -Name 'hub-vnet' `
-VirtualNetworkId $vnet.id -EnableRegistration

# Attach NSG to VM NIC
$nic = Get-AzNetworkInterface -ResourceGroupName "RG1" -Name "primary NIC of VM"
$nsg = Get-AzNetworkSecurityGroup -ResourceGroupName "RG1" -Name "NSG01"
$nic.NetworkSecurityGroup = $nsg
$nic | Set-AzNetworkInterface 