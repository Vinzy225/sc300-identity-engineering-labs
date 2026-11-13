# LAB-12 — Configuration drift, CI and portfolio release

**Week:** 12 · **Domain:** PORTFOLIO ONLY · M365DSC/CI (plus D4 governance)
**Licence:** PowerShell tools free; DSC components may require premium workload licences; GitHub Actions free usage subject to plan limits

**Outcome:** Publish four recruiter-friendly projects or a clearly structured monorepo with demonstrable automated checks.

**Learn:** M365DSC, declarative drift, Pester, PSScriptAnalyzer, GitHub Actions, test evidence and responsible public release.

## Execute in order

1. Define a minimal approved baseline: identity inventory counts, CA policy list, app registration controls and role inventory. Keep raw tenant snapshots private.
2. Install Microsoft365DSC and confirm available resource coverage; test export of one small supported resource only if your tenant supports it.
3. Introduce one deliberate harmless change, then compare expected and actual configuration with a documented read-only script or DSC export; record what was compared.
4. Create a Git branch for the change; run local PowerShell syntax validation, PSScriptAnalyzer and Pester tests for the safe reusable helper functions.
5. Enable .github/workflows/powershell-ci.yml. The workflow must validate scripts and tests only: it must not connect to the tenant from a public pull request.
6. Prove failure handling by adding a deliberate syntax error on a temporary branch; show CI failure, fix it and show successful status.
7. Complete a sanitized evidence pack for Labs 1–12. Ensure raw reports, UPNs, tenant IDs, screenshots with identifiable data, client IPs and secrets are absent.
8. Write the top-level README with business problems, architecture, lab status labels, reusable patterns, security model and links to evidence. Use docs/templates/README-LAB-TEMPLATE.md.
9. For each project or lab, add an operational limitation and a production-hardening backlog rather than claiming production deployment.
10. Publish a release tag v1.0-lab and document what a reviewer can reproduce in a fresh tenant, with exact prerequisites and estimated cost.

## Tests you must run

- [ ] Positive: CI passes and a new engineer can follow README without guessing.
- [ ] Negative: deliberate syntax error fails CI before merge.
- [ ] Publication: a search for your real UPN/tenant ID in tracked files returns no matches.

## Capture these exact artifacts

- [ ] `01-successful-ci-run.png`
- [ ] `02-failed-then-fixed-ci.png`
- [ ] `03-drift-difference-sanitized.md`
- [ ] `RELEASE-NOTES.md — known limitations and next steps`

## Repo deliverables

- `.github/workflows/powershell-ci.yml`
- `docs/labs/LAB-12.md`
- `README.md`

## Exam trap

Declarative configuration detection is different from automatically applying configuration; no autonomous remediation for sensitive identity policies.

## Results / failure notes

Execution status: NOT TESTED

What worked:

What failed:

What I changed:

Where I would add production safeguards:

## Exact automation path

Use `Install-Module Microsoft365DSC -Scope CurrentUser` to set up; `Export-M365DSCConfiguration` only with a validated workload authentication path. Run GitHub Actions PowerShell parser/Pester checks; the CI must NOT have tenant privileges.

## Exact portal verification

GitHub > Actions shows fail-then-pass; Entra baseline comparison is read-only unless change approved.
