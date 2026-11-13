# Read-only entitlement-management inventory, aggregate count only.
[CmdletBinding()]
param([Parameter(Mandatory)][string]$TenantId,
      [string]$OutputPath='./local-only/LAB-07-accesspackages.json')
$ErrorActionPreference='Stop'
Import-Module Microsoft.Graph.Authentication
Connect-MgGraph -TenantId $TenantId -Scopes 'EntitlementManagement.Read.All' -NoWelcome
try {
  $items=@();$uri='/v1.0/identityGovernance/entitlementManagement/accessPackages?$top=100'
  do{$r=Invoke-MgGraphRequest -Method GET -Uri $uri;$items+=@($r.value);$uri=$r.'@odata.nextLink'}while($uri)
  $labCount=@($items|Where-Object {$_.displayName -like 'SC300-*'}).Count
  New-Item -ItemType Directory -Force -Path (Split-Path $OutputPath -Parent)|Out-Null
  [ordered]@{LabPackageCount=$labCount;PackageIdsExported=$false}|ConvertTo-Json|
       Set-Content $OutputPath -Encoding utf8
  Write-Host "Observed $labCount synthetic access packages."
}finally{Disconnect-MgGraph|Out-Null}
