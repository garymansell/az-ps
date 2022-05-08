#Export a Template
Export-AzResourceGroup -ResourceGroupName “ps-course-rg" -Path "C:\downloads“
-Resource /subscriptions/123/resourceGroups/ps-course-rg `
/providers/Microsoft.network/networksecuritygroups/web-nsg

#Deploy a Template
$templateFile = "{provide-the-path-to-the-template-file}"
New-AzResourceGroupDeployment -Name`
  -Name blanktemplate `
  -ResourceGroupName myResourceGroup `
  -TemplateFile $templateFile`


# To deploy from a template (SAS.json) in a Storage account Container (private) with SAS token protection
$templateuri = New-AzStorageBlobSASToken -Container "private" -Blob "SAS.json" -Permission r -ExpiryTime (Get-Date).AddHours(2.0) -FullURi
New-AzResourGroup -Name "RG1" -Location "uksouth"
New-AzResourceGroupDeployment -ResourceGroupName "RG1" -TemplateUri $templateuri

