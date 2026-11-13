# LAB-01 — Tenant baseline and Graph inventory

**Week:** 01 · **Domain:** D1 · Manage user identities
**Licence:** Entra Free sufficient for basic inventory; administrative permissions still required

**Outcome:** Establish a fictional organization and export a repeatable, privacy-safe baseline.

**Learn:** Initial tenant configuration, user/group properties, Graph SDK delegated scopes, pagination and administrative roles.

## Execute in order

1. Create a fictional company named “Baobab Services”. On paper define HR, Finance and IT, three test users, and one nonprivileged operator. Do not use names of real colleagues.
2. Sign into your own Entra test tenant. Under Identity > Overview record the verified .onmicrosoft.com suffix and subscription SKU in your private lab notebook; never place its tenant ID in a public file.
3. Install PowerShell 7, Git, VS Code, Microsoft.Graph.Authentication, Microsoft.Graph.Users and Microsoft.Graph.Groups. Run Get-Module -ListAvailable and capture the version numbers.
4. Create a public GitHub repository from the starter ZIP. Keep the local-only/ and reports/raw/ paths out of Git; inspect .gitignore before proceeding.
5. In PowerShell run scripts/Export-LabDirectory.ps1 with -TenantId and -OutputPath local-only/LAB-01-raw.json; consent only User.Read.All and Group.Read.All. Record the exact invocation in your private notes.
6. Use scripts/New-LabJoiner.ps1 in planning mode to review the expected account naming pattern (the script does not change the tenant without -Execute).
7. Create three fictional SC300- prefixed accounts and security groups using the supported Graph SDK command examples in the lab notes; never create a fake employee in your work tenant.
8. Run the inventory again. Confirm only SC300- prefixed test objects appear in the exported lab subset. Compare the user count to Entra > Users and group count to Entra > Groups.
9. Create docs/architecture/LAB-01-tenant-map.md showing the fictitious company and its identities; write one paragraph differentiating OAuth delegated scopes from Entra RBAC roles.
10. Create an evidence pack consisting of a redacted portal screenshot, sanitized counts.json and a short TEST-RESULTS.md. Commit only the safe files.

## Tests you must run

- [ ] Positive: three synthetic accounts appear in Entra and the filtered inventory; expected count matches actual.
- [ ] Negative: repeat with missing consent or a reader without sufficient role; record the 403/consent response without exposing tokens.
- [ ] Repeatability: run the read-only inventory a second time and compare counts.

## Capture these exact artifacts

- [ ] `01-entra-users-redacted.png — screenshot of Entra > Users filtered by SC300-`
- [ ] `02-terminal-inventory-redacted.png — script run with tenant ID hidden`
- [ ] `counts.public.json — sanitized counts and fictional labels`
- [ ] `TEST-RESULTS.md — observed counts, failures and corrections`

## Repo deliverables

- `scripts/Export-LabDirectory.ps1`
- `docs/labs/LAB-01.md`
- `evidence/LAB-01/`

## Exam trap

A Graph OAuth scope does not replace the directory role required by the action.

## Results / failure notes

Execution status: NOT TESTED

What worked:

What failed:

What I changed:

Where I would add production safeguards:

## Exact automation path

Run `./scripts/Export-LabDirectory.ps1 -TenantId <private-guid>`. Scope: `User.Read.All`, `Group.Read.All`. For creating lab users use `New-MgUser` with `User.ReadWrite.All`, not Directory.ReadWrite.All.

## Exact portal verification

Entra > Identity > Users and Groups; compare SC300- prefix totals.
