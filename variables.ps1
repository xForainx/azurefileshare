#Credentials
$user = "sylvain.petit@iclassroom.fr"
$pass = Get-Content -Path C:\testsyl\syl.txt

#Global variables
$rgSpokeName = "devops-rg-fr-bidart2-01"
$location = "francecentral"
$tag = "DeploymentType=CLI"

#New VNET
$spokeVnetName = "sylVnetCLI"
$VnetAddressPrefix = "10.64.0.0/16"
$subnetName = "subnet1"
$subnetAddressPrefix = "10.64.1.0/24"

#Peering new VNET -> Hub
$PeeringNameVH = "$spokeVnetName-to-hub"
$rgHubName = "rg-fr-qual-hubnetwork"
$HubVnetName = "vnet-fr-qual-hubnetwork"
$fullHubVnetName = "/subscriptions/912b0429-2915-44a1-ab5a-7d2048cfa642/resourceGroups/$rgHubName/providers/Microsoft.Network/virtualNetworks/$HubVnetName"
$fullSpokeVnetName = "/subscriptions/912b0429-2915-44a1-ab5a-7d2048cfa642/resourceGroups/$rgSpokeName/providers/Microsoft.Network/virtualNetworks/$spokeVnetName"

#Peering Hub -> new VNET
$PeeringNameHV = "hub-to-$spokeVnetName"

#Storage account
$storageAccountName = "sasylcli"

#FileShare
$publicFileShareName = "public"
$supportFileShareName = "support"

#Private endpoint
$privateEndpointName = "pe-sasylcli"
$nicPrivateEndpointName = "nic-$privateEndpointName"