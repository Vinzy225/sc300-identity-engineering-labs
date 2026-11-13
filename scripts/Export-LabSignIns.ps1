# Sign-in summary only. Graph API access may require P1/P2 and Reports Reader role.
[CmdletBinding()]
param(
    [Parameter(Mandatory)][string]$TenantId,
    [ValidateRange(1,168)][int]$Hours=24,
    [string]$OutputPath='./local-only/LAB-04-signins.json'
)
$ErrorActionPreference='Stop'
Import-Module Microsoft.Graph.Authentication
Connect-MgGraph -TenantId $TenantId -Scopes 'AuditLog.Read.All' -NoWelcome
try {
    $since=[datetime]::UtcNow.AddHours(-$Hours).ToString('yyyy-MM-ddTHH:mm:ssZ')
    $uri="/v1.0/auditLogs/signIns?`$filter=createdDateTime ge $since&`$top=100"
    $events=@(); $pages=0
    do {
        $result=Invoke-MgGraphRequest -Method GET -Uri $uri
        $events+=@($result.value);$uri=$result.'@odata.nextLink';$pages++
        if($pages -ge 10) {Write-Warning 'Limited to 10 pages for a safe lab run.';break}
    } while ($uri)
    $counts=$events | Group-Object -Property { if ($_.status.errorCode -eq 0) { 'Success' } else { 'Failure' } }
    $safe=@($counts | ForEach-Object { [ordered]@{ Result=$_.Name; Count=$_.Count }})
    New-Item -ItemType Directory -Force -Path (Split-Path $OutputPath -Parent) | Out-Null
    $safe | ConvertTo-Json -Depth 5 | Set-Content $OutputPath -Encoding utf8
    Write-Host "Summarized $($events.Count) events. No UPNs or IPs exported."
} finally {Disconnect-MgGraph | Out-Null}
