#Azure Role Assignment
New-AzRoleAssignment -SignInName janis.thomas@becausesecurity.com `
-RoleDefinitionName "Virtual Machine Contributor" `
-ResourceGroupName ps-course-rg

Get-AzRoleAssignment -ResourceGroupName RG01    

Get-AzDenyAssignment -ResourceGroupName RG01

#Get Role definition actions

(Get-AzRoleDefinition "virtual machine contributor").actions

#Create a Custom Role
$role = Get-AzRoleDefinition "Virtual Machine Contributor"
$role.Id = $null
$role.Name = “VM Reader"
$role.Description = “Can see VMs"
$role.Actions.Clear()
$role.Actions.Add("Microsoft.Storage/*/read")
$role.Actions.Add("Microsoft.Network/*/read")
$role.Actions.Add("Microsoft.Compute/*/read")
$role.AssignableScopes.clear()
$role.AssignableScopes.Add("/subscriptions/00000-1111-2222-aaaa-123456778")
New-AzRoleDefinition -Role $role


#Look at available operations
Get-AzProviderOperation -OperationSearchString "Microsoft.Compute/*"
Get-AzProviderOperation -OperationSearchString "Microsoft.Compute/virtualMachines/*/action" | ft Operation, OperationName
Get-AzProviderOperation -OperationSearchString "Microsoft.Network/*"
Get-AzProviderOperation -OperationSearchString "Microsoft.Storage/*"

#Look at roles
Get-AzRoleDefinition | FT Name, Description
Get-AzRoleDefinition | measure
Get-AzRoleDefinition Contributor | FL Actions, NotActions
(Get-AzRoleDefinition "Virtual Machine Contributor").Actions


#look at roles that have something to do with compute
$roles = Get-AzRoleDefinition
foreach ($roledef in $roles)
{
    if ($roledef.Actions -match "^Microsoft.Compute/virtualMachines/" -or
    $roledef.Actions -match "^Microsoft.Compute/\*" -or $roledef.Actions -match
    "^\*/")
    {
        Write-Output "Role: $($roledef.Name)"
    }
}

#create a new role based on existing
Get-AzProviderOperation "Microsoft.Compute/virtualMachines/*" | FT OperationName, Operation, Description -AutoSize
$sub = Get-AzSubscription -SubscriptionName "SavillTech Dev Subscription"
$role = Get-AzRoleDefinition "Virtual Machine Contributor"
$role.Name = "Virtual Machine Operator"
$role.Description = "Can monitor and restart virtual machines."
$role.Actions.Remove("Microsoft.Compute/virtualMachines/*")
$role.Actions.Remove("Microsoft.Compute/virtualMachineScaleSets/*")
$role.Actions.Add("Microsoft.Compute/virtualMachines/read")
$role.Actions.Add("Microsoft.Compute/virtualMachines/start/action")
$role.Actions.Add("Microsoft.Compute/virtualMachines/restart/action")
$role.AssignableScopes.Clear()
$role.AssignableScopes.Add("/subscriptions/$($sub.id)")
New-AzRoleDefinition -Role $role

#OR export to JSON, edit the json and import again!
Get-AzRoleDefinition -Name "Virtual Machine Contributor" | ConvertTo-Json | Out-File c:\temp\vmoperator.json
<#
        Remove the ID and IsCustom
            "Microsoft.Compute/*/read",
    "Microsoft.Network/*/read",
    "Microsoft.Storage/*/read",
    "Microsoft.Compute/virtualMachines/start/action",
    "Microsoft.Compute/virtualMachines/restart/action",
            "Microsoft.Resources/subscriptions/resourceGroups/read",
            "Microsoft.Storage/storageAccounts/listKeys/action",
            "Microsoft.Support/*",
    "Microsoft.Authorization/*/read",
    "Microsoft.Insights/alertRules/*"
        Add a subscription to restrict the role to, Get-AzSubscription | ft Name, SubscriptionId
                "AssignableScopes":  [
                             "/subscriptions/<sub ID>"
                         ]
#>
New-AzRoleDefinition -InputFile C:\temp\vmoperator.json