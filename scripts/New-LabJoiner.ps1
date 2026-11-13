# WARNING: only in a personal training tenant. Default is PLAN ONLY.
[CmdletBinding()]
param(
    [Parameter(Mandatory)][string]$TenantId,
    [Parameter(Mandatory)][ValidatePattern('^sc300-[a-z0-9-]+$')][string]$Alias,
    [Parameter(Mandatory)][string]$DisplayName,
    [Parameter(Mandatory)][string]$Department,
    [Parameter(Mandatory)][string]$UpnDomain,
    [switch]$Execute
)
$ErrorActionPreference = 'Stop'
$upn = "$Alias@$UpnDomain"
if (-not $Execute) {
    Write-Host "PLAN ONLY: create $Alias in department $Department (domain supplied at runtime)."
    Write-Host 'No change was made. Add -Execute only after reviewing the plan.'
    return
}
Import-Module Microsoft.Graph.Authentication
Import-Module Microsoft.Graph.Users
Connect-MgGraph -TenantId $TenantId -Scopes 'User.ReadWrite.All' -NoWelcome
try {
    $existing = Get-MgUser -Filter "userPrincipalName eq '$upn'" -ErrorAction Stop
    if ($existing) { Write-Host 'SKIP: account already exists; no duplicate created.'; return }
    $secure = Read-Host 'Enter a TEMPORARY LAB ONLY password (never save to disk)' -AsSecureString
    $ptr = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($secure)
    try {
        $temporaryPlainText = [Runtime.InteropServices.Marshal]::PtrToStringBSTR($ptr)
        $profile = @{ password=$temporaryPlainText; forceChangePasswordNextSignIn=$true }
        New-MgUser -AccountEnabled -DisplayName $DisplayName -MailNickname $Alias `
            -UserPrincipalName $upn -Department $Department -PasswordProfile $profile | Out-Null
        Write-Host 'CREATED: one synthetic account. Inspect Entra portal to verify.'
    } finally {
        [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($ptr)
        Remove-Variable temporaryPlainText,profile -ErrorAction SilentlyContinue
    }
} finally { Disconnect-MgGraph | Out-Null }
