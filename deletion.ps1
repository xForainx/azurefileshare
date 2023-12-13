. ./variables.ps1

$connectedToAzure = az account show

if (! $connectedToAzure) {
    az login --user $user --password $pass
}
else {
    $cloudName = az account show --query "name"
    Write-Host "Already connected to $cloudName"
}

az network private-endpoint delete --name $privateEndpointName --resource-group $rgSpokeName

az storage share-rm delete --storage-account $storageAccountName --name $publicFileShareName
az storage share-rm delete --storage-account $storageAccountName --name $supportFileShareName
az storage account delete -n $storageAccountName -g $rgSpokeName

az network vnet peering delete -g $rgHubName -n $PeeringNameHV --vnet-name $HubVnetName

az network vnet delete --resource-group $rgSpokeName --name $spokeVnetName --subscription 912b0429-2915-44a1-ab5a-7d2048cfa642