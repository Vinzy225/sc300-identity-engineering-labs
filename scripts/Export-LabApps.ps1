# No client secrets, certificates, tenant IDs or app IDs are written.
[CmdletBinding()]
param([Parameter(Mandatory)][string]$TenantId,
      [string]$OutputPath='./local-only/LAB-05-app-summary.json')
$ErrorActionPreference='Stop'
Import-Module Microsoft.Graph.Authentication
Connect-MgGraph -TenantId $TenantId -Scopes 'Application.Read.All' -NoWelcome
try {
    $apps=@();$uri='/v1.0/applications?$select=displayName,appId&$top=100'
    do{$r=Invoke-MgGraphRequest -Method GET -Uri $uri;$apps+=@($r.value);$uri=$r.'@odata.nextLink'}while($uri)
    $sp=@();$uri='/v1.0/servicePrincipals?$select=displayName,appId&$top=100'
    do{$r=Invoke-MgGraphRequest -Method GET -Uri $uri;$sp+=@($r.value);$uri=$r.'@odata.nextLink'}while($uri)
    $lab=@($apps | Where-Object {$_.displayName -like 'SC300-*'})
    $safe=[ordered]@{LabAppRegistrationCount=$lab.Count;
      MatchingServicePrincipalCount=@($sp | Where-Object {$_.appId -in $lab.appId}).Count;
      Note='Source identifiers were intentionally excluded.'}
    New-Item -ItemType Directory -Force -Path (Split-Path $OutputPath -Parent)|Out-Null
    $safe|ConvertTo-Json|Set-Content $OutputPath -Encoding utf8
    Write-Host 'Exported sanitized synthetic-app statistics.'
}finally{Disconnect-MgGraph|Out-Null}
