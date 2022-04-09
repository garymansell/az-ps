#Create VM
New-AzVm
       -ResourceGroupName <resource group name>`
       -Name <machine name>`
       -Credential <credentials object>`
       -Location <location>`
       -Image <image name>`

#Change VM
Set-AzVMOperatingSystem
Set-AzVMSourceImage
Add-AzVMNetworkInterface
Set-AzVMOSDisk

#Delete VM
Remove-AzVM -NoWait -Name <> 

#Start VM
Start-AzVM -NoWait -Name <>

#Stop VM
Stop-AzVM -NoWait -Name <>

#Restart VM
Restart-AzVM -NoWait -Name <>

#Update VM Configuration
Update-AzVM

#List VM(s)
Get-AzVM -Status
Get-AzVM -Status -Name <name>

#Get a VM object as a variable
$vm= Get-AzVM -Name <name> -ResourceGroupName <name>

#Get a VM and Update config
$ResourceGroupName = "RG"
$vm = Get-AzVM  -Name MyVM -ResourceGroupName $ResourceGroupName
$vm.HardwareProfile.vmSize = "Standard_DS3_v2"
Update-AzVM -ResourceGroupName $ResourceGroupName  -VM $vm

#Get a VM's Public IP
$vm | Get-AzPublicIpAddress

#Delete NIC
$vm | Remove-AzNetworkInterface -Force

#To set a static IP on a NIC
$Nic = Get-AzNetworkInterface -ResourceGroupName "ResourceGroup1" -Name "NetworkInterface1" 
$Nic.IpConfigurations[0].PrivateIpAddress = "10.0.1.20" 
$Nic.IpConfigurations[0].PrivateIpAllocationMethod = "Static" 
$Nic.Tag = @{Name = "Name"; Value = "Value"} 
Set-AzNetworkInterface -NetworkInterface $Nic
