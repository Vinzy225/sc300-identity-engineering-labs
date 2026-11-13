# LAB-07 — Entitlement management and access reviews

**Week:** 07 · **Domain:** D4 · Identity governance
**Licence:** Entra ID Governance / Entra Suite for many entitlement scenarios; some P2 access-review functions; verify current entitlement per feature

**Outcome:** Model time-bound business access with requests, approvals and expiration.

**Learn:** Catalog, access package, resource roles, requester policy, approver, expiration, access reviews and lifecycle.

## Execute in order

1. Write the business request: external auditor needs read access to a fictional Finance resource for 14 days, approved by Finance owner.
2. Create the SC300-Finance-Auditors security group using Graph and verify it has no unnecessary administrative role.
3. If licensed, create a catalog and access package using Microsoft Graph entitlementManagement APIs. If not, produce a documented request/approval simulation and mark it clearly.
4. Configure a request policy for a specific requester group, named approver and expiration date; record the object relationships in a diagram.
5. Submit a request as the test user and approve as the separate approver identity. Never test requester and approver in the same unrestricted admin context.
6. Inspect the resulting membership and package assignment; verify both Graph read-only output and Entra > Identity Governance.
7. Create a group-membership access review when licensing permits, assign an independent reviewer and schedule a short review period.
8. Mark one synthetic user access as denied in a controlled test and inspect resulting audit history; do not auto-remove access in a shared environment.
9. Explain why group membership alone is not a full entitlement lifecycle and how external guest expiry differs from user deletion.
10. Prepare sanitized request/approval decision evidence and a diagram; include an explicit LICENCE-BLOCKED section if functionality was unavailable.

## Tests you must run

- [ ] Positive: approved access results in intended group membership when supported.
- [ ] Negative: nonapproved requester is denied or blocked by request policy.
- [ ] Lifecycle: expected expiration/review behavior documented and observed or simulated.

## Capture these exact artifacts

- [ ] `01-access-package-redacted.png`
- [ ] `02-access-request-and-review-redacted.png`
- [ ] `03-approval-flow.png`
- [ ] `TEST-RESULTS.md — status: VERIFIED or SIMULATED`

## Repo deliverables

- `docs/labs/LAB-07.md`
- `docs/architecture/entitlement-approval.md`

## Exam trap

Entitlement management is not simply putting users into groups; licensing and workflows differ by feature.

## Results / failure notes

Execution status: NOT TESTED

What worked:

What failed:

What I changed:

Where I would add production safeguards:

## Exact automation path

Run `./scripts/Export-LabAccessPackages.ps1 -TenantId <private-guid>`. Scope: `EntitlementManagement.Read.All`. To create packages use Graph `/identityGovernance/entitlementManagement/accessPackages` with `EntitlementManagement.ReadWrite.All` and tenant licence.

## Exact portal verification

Entra > Identity Governance > Entitlement management > Access packages; separately inspect review result.
