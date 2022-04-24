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
