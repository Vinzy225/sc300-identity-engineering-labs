# LAB-09 — Hybrid identity, B2B and cross-tenant scenarios

**Week:** 09 · **Domain:** D1 · Manage user identities
**Licence:** Guest invitations often available in basic tenants; cross-tenant sync, advanced policies or hybrid servers may require licensing/infrastructure

**Outcome:** Show you can choose the correct architecture even when free lab hosting is limited.

**Learn:** Cloud Sync vs Connect Sync, password hash sync vs PTA, B2B collaboration, cross-tenant access and external users.

## Execute in order

1. Draw two architectures: on-premises AD DS to Entra Cloud Sync, and Entra B2B guest collaboration across tenants.
2. Create a fictional business partner story requiring a guest to access one app, not global directory privileges.
3. If you have a second personal tenant or an approved partner test account, invite one external test user using Graph invitation API. Otherwise use documented sample API responses.
4. Inspect guest userType and external collaboration settings; record guest lifecycle and access termination procedure.
5. Compare tenant restrictions, inbound and outbound cross-tenant settings, and cross-tenant synchronization responsibilities.
6. For hybrid scenario, use a local VM with AD DS only if hardware/time permits; otherwise document Cloud Sync and Connect Sync components and failure modes without misrepresenting deployment.
7. Explain in one decision table when password hash sync, pass-through authentication and federation are appropriate.
8. Read hybrid sync monitoring documentation and write three troubleshooting runbooks: source anchor mismatch, duplicate identity, and failed sync.
9. Capture a redacted guest invitation result or simulator payload and a hybrid architecture diagram.
10. Write an exam flashcard contrasting B2B invitation and cross-tenant synchronization.

## Tests you must run

- [ ] Positive: guest invitation changes only authorized external collaboration state when tenant available.
- [ ] Negative: an unapproved external domain or app is denied under documented policy in a safe test.
- [ ] Documentation: deployment status labelled VERIFIED, DESIGN ONLY or SIMULATED.

## Capture these exact artifacts

- [ ] `01-b2b-flow.png`
- [ ] `02-guest-user-redacted.png or simulated.json`
- [ ] `03-hybrid-auth-decision-table.md`
- [ ] `TEST-RESULTS.md — tested and untested boundaries`

## Repo deliverables

- `docs/labs/LAB-09.md`
- `docs/architecture/hybrid-b2b.md`

## Exam trap

B2B guest access, cross-tenant sync and Entra Connect synchronization solve different problems.

## Results / failure notes

Execution status: NOT TESTED

What worked:

What failed:

What I changed:

Where I would add production safeguards:

## Exact automation path

Run `./scripts/Export-LabGuestSummary.ps1 -TenantId <private-guid>`. Scope: `User.Read.All`. For a real invitation use `POST /invitations` with delegated `User.Invite.All` and an allowed guest identity.

## Exact portal verification

Entra > Users > All users filter Guest; compare count and invited test identity.
