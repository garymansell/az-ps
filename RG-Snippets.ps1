#List Resource Groups

Get-AzResourceGroup
Get-AzResourceGroup  | Format-Table
Get-AzResource -ResourceGroupName <name>

#Create Resource Group
New-AzResourceGroup -Name <name> -Location <location>

#Set Default Resource Group
Set-AzDefault -ResourceGroupName <name>

