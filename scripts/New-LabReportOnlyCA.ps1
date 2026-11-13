# Safety guard: report-only CA policy scoped to one group, excludes emergency user.
[CmdletBinding()]
param(
    [Parameter(Mandatory)][string]$TenantId,
    [Parameter(Mandatory)][string]$PilotGroupId,
    [Parameter(Mandatory)][string]$BreakGlassUserId,
    [string]$DisplayName = 'SC300-LAB-ReportOnly-MFA',
    [switch]$Execute
)
$ErrorActionPreference='Stop'
foreach ($id in @($TenantId,$PilotGroupId,$BreakGlassUserId)) {
    $parsed=[guid]::Empty
    if (-not [guid]::TryParse($id,[ref]$parsed)) {throw 'Tenant/group/user identifier must be a valid GUID.'}
}
if ($DisplayName -notlike 'SC300-*') {throw 'Policy must begin SC300-'}
$body=@{
    displayName=$DisplayName
    state='enabledForReportingButNotEnforced'
    conditions=@{
        users=@{includeGroups=@($PilotGroupId);excludeUsers=@($BreakGlassUserId)}
        applications=@{includeApplications=@('All')}
        clientAppTypes=@('all')
    }
    grantControls=@{operator='OR';builtInControls=@('mfa')}
}
if (-not $Execute) {
    Write-Host "PLAN ONLY: $DisplayName; report-only; one pilot group; emergency user excluded."
    return
}
Import-Module Microsoft.Graph.Authentication
Connect-MgGraph -TenantId $TenantId `
    -Scopes 'Policy.Read.All','Policy.ReadWrite.ConditionalAccess' -NoWelcome
try {
    $existing=Invoke-MgGraphRequest -Method GET -Uri '/v1.0/identity/conditionalAccess/policies'
    if (@($existing.value | Where-Object {$_.displayName -eq $DisplayName}).Count -gt 0) {
        Write-Host 'SKIP: policy of that name exists; no duplicate created.'
        return
    }
    $json=$body | ConvertTo-Json -Depth 15
    $created=Invoke-MgGraphRequest -Method POST -Uri '/v1.0/identity/conditionalAccess/policies' `
        -Body $json -ContentType 'application/json'
    Write-Host 'CREATED a report-only Conditional Access policy; verify in Entra before use.'
} finally { Disconnect-MgGraph | Out-Null }
