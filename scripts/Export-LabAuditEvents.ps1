# Summarizes directory audit activities without object IDs or actor UPNs.
[CmdletBinding()]
param([Parameter(Mandatory)][string]$TenantId,
      [ValidateRange(1,168)][int]$Hours=24,
      [string]$OutputPath='./local-only/LAB-10-audit-summary.json')
$ErrorActionPreference='Stop'
Import-Module Microsoft.Graph.Authentication
Connect-MgGraph -TenantId $TenantId -Scopes 'AuditLog.Read.All' -NoWelcome
try {
  $since=[datetime]::UtcNow.AddHours(-$Hours).ToString('yyyy-MM-ddTHH:mm:ssZ')
  $uri="/v1.0/auditLogs/directoryAudits?`$filter=activityDateTime ge $since&`$top=100"
  $events=@();$pages=0
  do{$r=Invoke-MgGraphRequest -Method GET -Uri $uri;$events+=@($r.value);$uri=$r.'@odata.nextLink';$pages++;if($pages -ge 10){break}}while($uri)
  $safe=@($events | Group-Object activityDisplayName | ForEach-Object {
      [ordered]@{Operation=$_.Name;Count=$_.Count}
  })
  New-Item -ItemType Directory -Force -Path (Split-Path $OutputPath -Parent)|Out-Null
  $safe|ConvertTo-Json -Depth 5|Set-Content $OutputPath -Encoding utf8
  Write-Host "Aggregated $($events.Count) audit events (no principals exported)."
}finally{Disconnect-MgGraph|Out-Null}
