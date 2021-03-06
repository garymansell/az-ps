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
Get-AzVM -status | ft name, powerstate -AutoSize
Get-AzVM -status | where {$_.powerstate -ne "VM Running"}

#Redeploy VM (can't access)
Set-AzVM -Redeploy -ResourceGroupName ‘ps-course-rg’ -Name “linux-1“

#Get a VM object as a variable
$vm= Get-AzVM -Name <name> -ResourceGroupName <name>

#Get a VM and Update config
$ResourceGroupName = "RG"
$vm = Get-AzVM  -Name MyVM -ResourceGroupName $ResourceGroupName
$vm.HardwareProfile.vmSize = "Standard_DS3_v2"
Update-AzVM -ResourceGroupName $ResourceGroupName  -VM $vm


#Script to create multiple VMs:
param([string]$resourceGroup)
$adminCredential = Get-Credential -Message "Enter a username and password for the VM administrator."
For ($i = 1; $i -le 3; $i++)
{
    $vmName = "ConferenceDemo" + $i
    Write-Host "Creating VM: " $vmName
    New-AzVm -ResourceGroupName $resourceGroup -Name $vmName -Credential $adminCredential -Image UbuntuLTS
}

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

#Delete Disk
Get-AzDisk -ResourceGroupName $vm.ResourceGroupName -DiskName $vm.StorageProfile.OSDisk.Name | Remove-AzDisk -Force

# Upload a local VHD disk to Azure
# Required parameters
$path = <your-filepath-here>.vhd
$resourceGroup = <your-resource-group-name>
$location = <desired-region>
$name = <desired-managed-disk-name>
# Optional parameters
# $Zone = <desired-zone>
# $sku=<desired-SKU>

# To use $Zone or #sku, add -Zone or -DiskSKU parameters to the command
Add-AzVhd -LocalFilePath $path -ResourceGroupName $resourceGroup -Location $location -DiskName $name

#Look at all extension images
Get-AzVmImagePublisher -Location "southcentralus" | Get-AzVMExtensionImageType | Get-AzVMExtensionImage | Select Type, Version

#View Windows Server images
$loc = 'SouthCentralUS'
#View the templates available
Get-AzVMImagePublisher -Location $loc
Get-AzVMImageOffer -Location $loc -PublisherName "MicrosoftWindowsServer"
Get-AzVMImageSku -Location $loc -PublisherName "MicrosoftWindowsServer" -Offer "WindowsServer"
Get-AzVMImage -Location $loc -PublisherName "MicrosoftWindowsServer" -Offer "WindowsServer" -Skus "2019-Datacenter-Core"
#can use -latest when actually using

#View Ubuntu
#View the templates available
Get-AzVMImagePublisher -Location $loc
Get-AzVMImageOffer -Location $loc -PublisherName "Canonical"
Get-AzVMImageSku -Location $loc -PublisherName "Canonical" -Offer "UbuntuServer"
Get-AzVMImage -Location $loc -PublisherName "Canonical" -Offer "UbuntuServer" -Skus "19.04"
Get-AzVMImage -Location $loc -PublisherName "Canonical" -Offer "UbuntuServer" -Skus "19.04" -Version 19.04.201908140


