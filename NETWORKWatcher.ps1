# Install network watcher agent extension
Set-AzVMExtension `
  -ResourceGroupName "myResourceGroup1" `
  -Location "WestUS" `
  -VMName "myVM1" `
  -Name "networkWatcherAgent" `
  -Publisher "Microsoft.Azure.NetworkWatcher" `
  -Type "NetworkWatcherAgentWindows" `
  -TypeHandlerVersion "1.4"

# Create a Network Watcher Packet Capture
$vm=Get-AzVM -ResourceGroupName "RG01" -Name "VM01"
$res=Get-AzResource | Where-Object {$_.ResourceType -eq "Microsoft.Network/networkWatchers" -and $_.Location -eq "uksouth"}
$networkWatcher = Get-AzNetworkWatcher -Name $res.Name -ResourceGroupName $res.ResourceGroupName
$diagnosticSA = Get-AzStorageAccount -ResourceGroupName "Diagnostics-RG" -Name "Diagnostics-Storage"
$filter1 = New-AzPacketCaptureFilterConfig -Protocol TCP -RemoteIPAddress "0.0.0.0-255.255.255.255" -LocalIPAddress "10.0.0.3" -LocalPort "1-65535" -RemotePort "22"
New-AzNetworkWatcherPacketCapture -NetworkWatcher $networkWatcher -TargetVirtualMachineId $vm.id -PacketCaptureName "CaptureSFTP" -StorageAccountId $diagnosticSA.Id -TimeLimitInSeconds 60 -Filter $filter1