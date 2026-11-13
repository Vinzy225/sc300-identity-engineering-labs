# Read-only. Publishes only SC300- synthetic-object counts and anonymous labels.
[CmdletBinding()]
param(
    [Parameter(Mandatory)][string]$TenantId,
    [string]$OutputPath = './local-only/LAB-01-summary.json',
    [string]$LabPrefix = 'SC300-'
)
$ErrorActionPreference = 'Stop'
Import-Module Microsoft.Graph.Authentication
Import-Module Microsoft.Graph.Users
Import-Module Microsoft.Graph.Groups
Connect-MgGraph -TenantId $TenantId -Scopes 'User.Read.All','Group.Read.All' -NoWelcome
try {
    $users = @(Get-MgUser -All -Property 'id,displayName,department,userPrincipalName' |
        Where-Object { $_.DisplayName -like "$LabPrefix*" })
    $groups = @(Get-MgGroup -All -Property 'id,displayName' |
        Where-Object { $_.DisplayName -like "$LabPrefix*" })
    $summary = [ordered]@{
        Scenario = 'Synthetic SC-300 lab inventory'
        UserCount = $users.Count
        GroupCount = $groups.Count
        Users = @($users | ForEach-Object -Begin {$i=0} -Process {
            $i++; [ordered]@{ Label=('lab-user-{0:d2}' -f $i); Department=$_.Department }
        })
        Groups = @($groups | ForEach-Object -Begin {$i=0} -Process {
            $i++; ('lab-group-{0:d2}' -f $i)
        })
        Note = 'No real IDs, display names, UPNs or tenant identifiers in this export.'
    }
    New-Item -ItemType Directory -Force -Path (Split-Path $OutputPath -Parent) | Out-Null
    $summary | ConvertTo-Json -Depth 10 | Set-Content -Path $OutputPath -Encoding utf8
    Write-Host "Lab inventory complete: $($users.Count) synthetic users; $($groups.Count) groups."
} finally { Disconnect-MgGraph | Out-Null }
