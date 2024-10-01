param dnsZoneName string = 'privatelink.blob.core.windows.net'
param dnsZoneRG string = toLower('Hybrid-AI-Sandbox-RG')
param dnsZoneSubscriptionId string = '1c7c2989-3f72-4947-82e7-4a0177af0028'
param recordSetName string = 'fonsitest'
param ttl int = 3600
param ipAddresses array = ['10.0.0.4'] // Add your private IP addresses here
param location string = 'eastus2' // Specify the location
// Reference the existing DNS zone in another subscription

resource privateDnsZone 'Microsoft.Network/privateDnsZones@2020-06-01' existing = {
  name: dnsZoneName
  scope: resourceGroup(dnsZoneSubscriptionId, dnsZoneRG)
}

module dnsRecordSetModule 'dnsRecordSetModule.bicep' = {
  name: 'dnsRecordSetModule'
  scope: resourceGroup(dnsZoneSubscriptionId, dnsZoneRG)
  params: {
    dnsZoneName: dnsZoneName
    recordSetName: recordSetName
    ttl: ttl
    ipAddresses: ipAddresses
    location: location
  }
}
