#Azure Private DNS Zone & Link

$zone = New-AzPrivateDnsZone -Name 'private.ps.com' `
-ResourceGroupName 'pluralsight-rg'

$link = New-AzPrivateDnsVirtualNetworkLink -ZoneName 'private.ps.com' `
-ResourceGroupName 'pluralsight-rg' -Name 'hub-vnet' `
-VirtualNetworkId $vnet.id -EnableRegistration
