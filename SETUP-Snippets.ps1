Install-Module -Name Az

Update-Module -Name Az

Get-Module
Get-Module -ListAvailable

Get-Help -NameGet-ChildItem -Detailed
<cmdlet> | Get-Member

Set-ExecutionPolicy -ExecutionPolicyRemoteSigned -ScopeCurrentUser

# Show Subscription
Get-AzContext

# Set Subscription
Set-AzContext -Subscription'00000000-0000-0000-0000-000000000000'

# Connect to Azure
Connect-AzAccount
Connect-AzAccount -Tenant 'xxxx-xxxx-xxxx-xxxx' -SubscriptionId 'yyyy-yyyy-yyyy-yyyy'

#List Azure Regions
Get-AzLocation



