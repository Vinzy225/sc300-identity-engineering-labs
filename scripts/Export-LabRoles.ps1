# Directory role assignments: aggregate count only.
[CmdletBinding()]
param([Parameter(Mandatory)][string]$TenantId,
      [string]$OutputPath='./local-only/LAB-08-role-count.json')
$ErrorActionPreference='Stop'
Import-Module Microsoft.Graph.Authentication
Connect-MgGraph -TenantId $TenantId -Scopes 'RoleManagement.Read.Directory' -NoWelcome
try {
  $roles=@();$uri='/v1.0/roleManagement/directory/roleAssignments?$top=100'
  do{$r=Invoke-MgGraphRequest -Method GET -Uri $uri;$roles+=@($r.value);$uri=$r.'@odata.nextLink'}while($uri)
  New-Item -ItemType Directory -Force -Path (Split-Path $OutputPath -Parent)|Out-Null
  [ordered]@{AssignmentCount=$roles.Count;IdentifiersExported=$false}|
     ConvertTo-Json|Set-Content $OutputPath -Encoding utf8
  Write-Host "Read-only directory role assignment count: $($roles.Count)."
}finally{Disconnect-MgGraph|Out-Null}
