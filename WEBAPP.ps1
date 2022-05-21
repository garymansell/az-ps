#Create a web app

New-AzAppServicePlan -Name $webappname -Location $location -ResourceGroupName myResourceGroup -Tier Free
# Create a Web App in the App Service Plan
New-AzWebApp -Name testapp-ResourceGroupName webapp-rg -Location centralus -AppServicePlan az104plan
# Scale Web App to 2 Workers
Set-AzAppServicePlan -NumberofWorkers 2 -Name az104plan -ResourceGroupName webapp-rg

