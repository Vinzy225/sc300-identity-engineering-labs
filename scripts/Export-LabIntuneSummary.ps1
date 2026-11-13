# Read-only Intune managed-device counts; licence required.
[CmdletBinding()]
param([Parameter(Mandatory)][string]$TenantId,
      [string]$OutputPath='./local-only/LAB-11-intune-summary.json')
$ErrorActionPreference='Stop'
Import-Module Microsoft.Graph.Authentication
Connect-MgGraph -TenantId $TenantId -Scopes 'DeviceManagementManagedDevices.Read.All' -NoWelcome
try {
  $devices=@();$uri='/v1.0/deviceManagement/managedDevices?$select=id,operatingSystem&$top=100'
  do{$r=Invoke-MgGraphRequest -Method GET -Uri $uri;$devices+=@($r.value);$uri=$r.'@odata.nextLink'}while($uri)
  $safe=@($devices|Group-Object operatingSystem|ForEach-Object {
      [ordered]@{OS=$_.Name;Count=$_.Count}
  })
  New-Item -ItemType Directory -Force -Path (Split-Path $OutputPath -Parent)|Out-Null
  $safe|ConvertTo-Json -Depth 5|Set-Content $OutputPath -Encoding utf8
  Write-Host "Read-only managed device count: $($devices.Count)."
}finally{Disconnect-MgGraph|Out-Null}
