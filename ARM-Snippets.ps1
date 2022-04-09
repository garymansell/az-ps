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
