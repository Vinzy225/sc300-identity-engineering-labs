Describe 'SC-300 repository safety and structure' {
  BeforeAll {
    $root = Split-Path $PSScriptRoot -Parent
    }
  It 'Has an explicit gitignore for confidential local files' {
    Test-Path (Join-Path $root '.gitignore') | Should -BeTrue
    (Get-Content (Join-Path $root '.gitignore') -Raw) | Should -Match 'local-only/'
  }
  It 'Every PowerShell script has a param block and declared Graph scopes' {
    Get-ChildItem (Join-Path $root 'scripts') -Filter '*.ps1' | ForEach-Object {
      $source=Get-Content $_.FullName -Raw
      $source | Should -Match '(?s)\bparam\s*\('
      $source | Should -Match 'Connect-MgGraph.*-TenantId'
      $source | Should -Match '-Scopes'
    }
  }
  It 'No private key files are versioned as sample artifacts' {
    @(Get-ChildItem $root -Recurse -File -Include '*.pfx','*.pem','*.key').Count | Should -Be 0
  }
}
