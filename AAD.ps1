#Connect to Azure AD
Install-Module -Name AzureAD

Import-Module AzureAD

Connect-AzureAD
Connect-AzureAD -TenantId b90226e1-e201-406e-a3d5-b760e311b962


#Create User
$PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
$PasswordProfile.Password = "P@ssw0rd8!"
$PasswordProfile.EnforceChangePasswordPolicy = $true
New-AzureADUser -DisplayName "Pat Smith" -PasswordProfile $PasswordProfile -UserPrincipalName "pats@timw.info" -AccountEnabled $true

#Create Group & Add Member
New-AzureADGroup -Description "Marketing" -DisplayName "Marketing" -MailEnabled $false -SecurityEnabled $true -MailNickName "Marketing"
Add-AzureADGroupMember -ObjectId "62438306-7c37-4638-a72d-0ee8d9217680" -RefObjectId "0a1068c0-dbb6-4537-9db3-b48f3e31dd76"
#Where ObjectID is the Group ID and RefObjectID is the member ID

#Get user by ID (or UPN)
Get-AzureADUser -ObjectId "testUpn@tenant.com"

#Get a user by userPrincipalName
Get-AzureADUser -Filter"userPrincipalName eq 'jondoe@contoso.com'"

#Bulk update user properties by Group
#Note object ID is using Mail, but should really be using UPN
$adGroupId = "<Azure AD Group Id here>"
$users = Get-AzureADGroupMember -ObjectId $adGroupId
foreach ($u in $users)
{
Write-Host $u.DisplayName
Set-AzureADUser -ObjectId $u.Mail -Department "<New Value>"
}

