#List Resource Groups

Get-AzResourceGroup
Get-AzResourceGroup  | Format-Table
Get-AzResource -ResourceGroupName <name>

#Create Resource Group
New-AzResourceGroup -Name <name> -Location <location>

#Set Default Resource Group
Set-AzDefault -ResourceGroupName <name>

#Move Azure Resources between RG's and Subs
Move-AzResource -DestinationResourceGroupName ‘ps-course-rg’ `
-ResourceId <myResourceId,myResourceId,myResourceId>

Move-AzResource -DestinationSubscriptionId “8bc4fbf0-blah-blah-blah-226b44e5db84" `
-DestinationResourceGroupName ‘ps-course-rg’ `
-ResourceId <myResourceId,myResourceId,myResourceId>
