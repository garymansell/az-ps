#Create Keyvault and configure VM Disk Encryption
New-AzKeyVault -Name 'demokv' -ResourceGroupName 'ps-course-rg’ `
-Location 'northcentralus' -EnabledForDiskEncryption
$KeyVault = Get-AzKeyVault -VaultName 'demokv' -ResourceGroupName 'ps-course-rg’

Set-AzVMDiskEncryptionExtension -ResourceGroupName 'ps-course-rg' -VMName 'linux-1’ `
-DiskEncryptionKeyVaultUrl $KeyVault.VaultUri `
-DiskEncryptionKeyVaultId $KeyVault.ResourceId

Get-AzVmDiskEncryptionStatus -ResourceGroupName "RG1" -VMName "VM1" 

Disable-AzVMDiskEncryption -ResourceGroupName "RG1" -VMName "VM1" -VolumeType {ALL, DATA, OS}

#Enable Diagnostic logging for Keyvault
Set-AzDiagnosticSetting -Name KeyVault-Diagnostics `
-ResourceId /subscriptions/…/Microsoft.KeyVault/vaults/mykeyvault `
-Category AuditEvent -MetricCategory AllMetrics -Enabled $true `
-StorageAccountId /…/Microsoft.Storage/storageAccounts/mystorageaccount `
-WorkspaceId /…/workspaces/myworkspace `
-EventHubAuthorizationRuleId /…/RootManageSharedAccessKey


# Add Access Policy to allow Keyvault to be used for template deployment (Admin Passwords)
Set-AzKeyVaultAccessPolicy -VaultName Contoso -EnabledForTemplateDeployment


#Look at secrets
(Get-AzKeyVaultSecret –VaultName 'SavKeyVault' `
    -Name TestSecret).SecretValueText

    