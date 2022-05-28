$res = Get-AzResource -ResourceGroupName "Gary-Admin-RG" -ResourceName "garysashare"
$res.tags.Add("Dept", "IT")
Set-AzResource -Tag $res.Tags -ResourceId $res.ResourceId -Force