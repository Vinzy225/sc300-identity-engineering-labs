# Read-only Conditional Access export; does not export conditions or object IDs.
[CmdletBinding()]
param(
    [Parameter(Mandatory)][string]$TenantId,
    [string]$OutputPath = './local-only/LAB-03-policy-summary.json'
)
$ErrorActionPreference='Stop'
Import-Module Microsoft.Graph.Authentication
Connect-MgGraph -TenantId $TenantId -Scopes 'Policy.Read.All' -NoWelcome
try {
    $all=@(); $uri='/v1.0/identity/conditionalAccess/policies?$top=100'
    do {
        $result=Invoke-MgGraphRequest -Method GET -Uri $uri
        $all+=@($result.value)
        $uri=$result.'@odata.nextLink'
    } while ($uri)
    $selected=@($all | Where-Object {$_.displayName -like 'SC300-*'} |
        ForEach-Object { [ordered]@{ displayName=$_.displayName; state=$_.state } })
    New-Item -ItemType Directory -Force -Path (Split-Path $OutputPath -Parent) | Out-Null
    $selected | ConvertTo-Json -Depth 6 | Set-Content $OutputPath -Encoding utf8
    Write-Host "Exported $($selected.Count) SC300- policy summaries (without IDs)."
} finally { Disconnect-MgGraph | Out-Null }
