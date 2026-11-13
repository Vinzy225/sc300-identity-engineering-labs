# Disables only sc300- lab users. Does not delete users or their data.
[CmdletBinding()]
param(
    [Parameter(Mandatory)][string]$TenantId,
    [Parameter(Mandatory)][string]$UserPrincipalName,
    [switch]$Execute
)
$ErrorActionPreference = 'Stop'
$localPart=($UserPrincipalName -split '@')[0]
if ($localPart -notmatch '^sc300-[a-z0-9-]+$') {throw 'Blocked: not a sc300- test identity.'}
if (-not $Execute) { Write-Host 'PLAN ONLY: disable one SC300- test user; no change.'; return }
Import-Module Microsoft.Graph.Authentication
Import-Module Microsoft.Graph.Users
Connect-MgGraph -TenantId $TenantId -Scopes 'User.ReadWrite.All' -NoWelcome
try {
    $user=Get-MgUser -UserId $UserPrincipalName -Property 'id,userPrincipalName,accountEnabled'
    if (-not $user.AccountEnabled) { Write-Host 'SKIP: test account already disabled.'; return }
    Update-MgUser -UserId $user.Id -AccountEnabled:$false
    $check=Get-MgUser -UserId $user.Id -Property 'id,accountEnabled'
    if ($check.AccountEnabled) { throw 'Verification failed: account still enabled.' }
    Write-Host 'VERIFIED: lab user disabled. Data preserved; no deletion performed.'
} finally { Disconnect-MgGraph | Out-Null }
