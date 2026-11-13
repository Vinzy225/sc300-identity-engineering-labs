# Read-only external-users report. No UPNs or external organizations exported.
[CmdletBinding()]
param([Parameter(Mandatory)][string]$TenantId,
      [string]$OutputPath='./local-only/LAB-09-guest-summary.json')
$ErrorActionPreference='Stop'
Import-Module Microsoft.Graph.Authentication
Import-Module Microsoft.Graph.Users
Connect-MgGraph -TenantId $TenantId -Scopes 'User.Read.All' -NoWelcome
try {
  $guests=@(Get-MgUser -All -Property 'id,userType'|Where-Object {$_.UserType -eq 'Guest'})
  New-Item -ItemType Directory -Force -Path (Split-Path $OutputPath -Parent)|Out-Null
  [ordered]@{GuestCount=$guests.Count;GuestIdentitiesExported=$false}|ConvertTo-Json|
     Set-Content $OutputPath -Encoding utf8
  Write-Host "Read-only guest account count: $($guests.Count)."
}finally{Disconnect-MgGraph|Out-Null}
