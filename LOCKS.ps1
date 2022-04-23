#Create Resource Lock
New-AzResourceLock –Locklevel CanNotDelete –LockName LockSite –ResourceName examplesite

#Remove Resource Locks from all resources in an RG
$RG = "rg1"
Get-AzResourceLock | `
Where-Object ResourceGroupName -EQ "$RG" |`
Remove-AzResourceLock -Force