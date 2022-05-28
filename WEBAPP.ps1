#Create a web app

New-AzAppServicePlan -Name $webappname -Location $location -ResourceGroupName myResourceGroup -Tier Free
# Create a Web App in the App Service Plan
New-AzWebApp -Name testapp-ResourceGroupName webapp-rg -Location centralus -AppServicePlan az104plan
# Scale Web App to 2 Workers
Set-AzAppServicePlan -NumberofWorkers 2 -Name az104plan -ResourceGroupName webapp-rg

# Use a custom DNS name for a root named domain name (i.e not www - so need to use "@")
New-AzDnsRecordSet -Name "@" -RecordType "A" -ZoneName "company.com" -ResourceGroupName "APP-RG" -Ttl 600 -DnsRecords (New-AzDnsRecordConfig -Ipv4Address "x.x.x.x")
New-AzDnsRecordSet -Name "@" -RecordType "TXT" -Ttl 600 -DnsRecords (New-AzDnsRecordConfig -Value "applicationname.azurewebsites.net")
