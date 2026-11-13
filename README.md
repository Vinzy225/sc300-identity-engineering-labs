# Identity Engineering Lab Portfolio — SC-300

> **Status:** Starter repository, NOT a claim of completed deployment.

A repeatable set of 12 lab scenarios using Microsoft Entra ID, Microsoft Graph PowerShell, Conditional Access, enterprise applications and identity governance, followed by two engineering extensions.

## Start here
1. Read `docs/templates/CAPTURE-INSTRUCTIONS.md`.
2. Read `docs/labs/LAB-01.md` and run the read-only inventory script.
3. Run changed operations ONLY against your personal tenant, and only after inspecting `-Execute` plans.
4. Record positive, negative and repeat/rollback test results.
5. Publish sanitized evidence and link it to this page.

## Domain map
- **D1:** Labs 1, 2, 9 — user identity and hybrid/B2B.
- **D2:** Labs 3, 4 — authentication, risk, Conditional Access.
- **D3:** Labs 5, 6 — enterprise applications and workload identities.
- **D4:** Labs 7, 8, 10 — entitlement, PIM and logs.
- **Beyond SC-300:** Labs 11, 12 — Intune/Autopilot and configuration-as-code/CI.

## Evidence statuses
Use only: VERIFIED IN LAB · PARTIAL · SIMULATED · DESIGN ONLY · LICENCE-BLOCKED · NOT STARTED. Never present a design/mock as a deployment.

## Security model
- Synthetic accounts with `sc300-` identifiers only.
- Graph delegated scopes declared per script; admin role required separately.
- Writes are PLAN ONLY by default and require an explicit `-Execute` switch.
- No secrets, tokens, identifiers, non-synthetic directory exports or PFX files in Git.
- Protected operations never run automatically from GitHub public pull requests.

## Lab index
- [Lab 01 — Tenant baseline and Graph inventory](docs/labs/LAB-01.md) · D1 · Manage user identities
- [Lab 02 — Joiner–Mover–Leaver lifecycle](docs/labs/LAB-02.md) · D1 · Manage user identities
- [Lab 03 — Passwordless, MFA and Conditional Access](docs/labs/LAB-03.md) · D2 · Authentication and access
- [Lab 04 — Risk, authentication methods and sign-in investigation](docs/labs/LAB-04.md) · D2 · Authentication and access
- [Lab 05 — Enterprise applications and SSO governance](docs/labs/LAB-05.md) · D3 · Workload identities (enterprise apps)
- [Lab 06 — Unattended workload identity and secure API access](docs/labs/LAB-06.md) · D3 · Workload identities
- [Lab 07 — Entitlement management and access reviews](docs/labs/LAB-07.md) · D4 · Identity governance
- [Lab 08 — Privileged Identity Management and scoped administration](docs/labs/LAB-08.md) · D4 · Identity governance
- [Lab 09 — Hybrid identity, B2B and cross-tenant scenarios](docs/labs/LAB-09.md) · D1 · Manage user identities
- [Lab 10 — Audit evidence, KQL and SC-300 exam readiness](docs/labs/LAB-10.md) · D1–D4 · Integrative exam practice
- [Lab 11 — Intune and Autopilot engineering extension](docs/labs/LAB-11.md) · PORTFOLIO ONLY · MD-102 skills (outside SC-300 core)
- [Lab 12 — Configuration drift, CI and portfolio release](docs/labs/LAB-12.md) · PORTFOLIO ONLY · M365DSC/CI (plus D4 governance)

## Official syllabus and licensing
- [SC-300 skills outline (effective Oct 28, 2026)](https://learn.microsoft.com/en-us/credentials/certifications/resources/study-guides/sc-300)
- [Microsoft 365 developer sandbox conditions](https://learn.microsoft.com/en-us/office/developer-program/microsoft-365-developer-program-get-started)
- [Entra licensing and CA requirements](https://learn.microsoft.com/en-us/entra/fundamentals/licensing)
- [Microsoft Graph create user](https://learn.microsoft.com/en-us/graph/api/user-post-users?view=graph-rest-1.0)
- [Microsoft Graph user role assignments](https://learn.microsoft.com/en-us/graph/api/rbacapplication-list-roleassignments?view=graph-rest-1.0)
- [Conditional Access policy create API](https://learn.microsoft.com/en-us/graph/api/conditionalaccessroot-post-policies?view=graph-rest-1.0)
- [Microsoft Entra sign-in logs with Graph](https://learn.microsoft.com/en-us/entra/identity/monitoring-health/howto-analyze-activity-logs-with-microsoft-graph)
- [Entra entitlement management licensing](https://learn.microsoft.com/en-us/entra/id-governance/entitlement-management-overview)

## Limits
Lab scripts have been authored for offline source inspection. Their Microsoft Graph behavior must be validated in your eligible personal tenant and version-pinned before production use.
