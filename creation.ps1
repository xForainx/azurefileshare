. ./variables.ps1

$connectedToAzure = az account show

if (! $connectedToAzure) {
    az login --user $user --password $pass
}
else {
    $cloudName = az account show --query "name"
    Write-Host "Already connected to $cloudName"
}

#Création VNET
az network vnet create --location $location --name $spokeVnetName --resource-group $rgSpokeName --address-prefix $VnetAddressPrefix --subnet-name $subnetName --subnet-prefixes $subnetAddressPrefix --tags $tag

#Peering new VNET -> Hub
az network vnet peering create -g $rgSpokeName -n $PeeringNameVH --vnet-name $spokeVnetName --remote-vnet $fullHubVnetName --allow-vnet-access yes --allow-forwarded-traffic yes --use-remote-gateways yes

#Peering Hub -> new VNET
az network vnet peering create -g $rgHubName -n $PeeringNameHV --vnet-name $HubVnetName --remote-vnet $fullSpokeVnetName --allow-vnet-access yes --allow-forwarded-traffic yes --allow-gateway-transit yes

#Storage account
az storage account create --name $storageAccountName --resource-group $rgSpokeName --location $location --sku Standard_LRS --public-network-access Disabled --tags $tag

#Public FileShare
az storage share-rm create -g $rgSpokeName --storage-account $storageAccountName --name $publicFileShareName --access-tier Hot

#Support FileShare
az storage share-rm create -g $rgSpokeName --storage-account $storageAccountName --name $supportFileShareName --access-tier Hot

#Private endpoint
az network private-endpoint create -g $rgSpokeName -n $privateEndpointName --nic-name $nicPrivateEndpointName --vnet-name $spokeVnetName --subnet $subnetName --private-connection-resource-id "/subscriptions/912b0429-2915-44a1-ab5a-7d2048cfa642/resourceGroups/$rgSpokeName/providers/Microsoft.Storage/storageAccounts/$storageAccountName" --group-id file --connection-name $storageAccountName --location $location --tags $tag