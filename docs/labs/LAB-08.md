# LAB-08 — Privileged Identity Management and scoped administration

**Week:** 08 · **Domain:** D4 · Identity governance
**Licence:** P2 or Entra ID Governance for PIM; some roles and AUs available at different tiers

**Outcome:** Audit standing privileges and demonstrate just-in-time elevation where licensed.

**Learn:** Permanent vs eligible roles, activation, approval, emergency access, role-assignment schedules and Administrative Units.

## Execute in order

1. Run scripts/Export-LabRoles.ps1 with RoleManagement.Read.Directory and save the real raw list privately; publish only role counts and synthetic names.
2. Review active directory roles in Entra > Roles & admins and identify whether any SC300- test identities hold standing administrator rights.
3. Create a scope model for an HR helpdesk administrator; explain when an Administrative Unit is appropriate and what it does NOT scope.
4. If PIM is licensed, assign one test identity an eligible low-risk role for a short duration; do not experiment with permanent Global Administrator grants.
5. Configure an activation setting such as MFA and justification and activate the eligible role as the eligible identity.
6. Observe role assignment before, during and after activation using Graph role schedule APIs where supported; capture timestamps but anonymize principal IDs.
7. If PIM is unavailable, inspect the API schema and write a simulator of the eligibility/activation state machine; label it SIMULATED.
8. Design two cloud-only emergency access accounts and describe monitoring and exclusion policy; do not publish real details or use them casually.
9. Produce an audit checklist ranking permanent privileges, approval quality, activation duration and expiry.
10. Summarize in TEST-RESULTS.md which privileges were changed, confirmed, left untouched and rolled back.

## Tests you must run

- [ ] Positive: role inventory matches portal role assignment count in scope.
- [ ] Negative: a noneligible user cannot self-activate a privileged role.
- [ ] Expiry: activated permission expires or is deliberately deactivated in lab.

## Capture these exact artifacts

- [ ] `01-role-inventory-sanitized.json`
- [ ] `02-pim-eligible-and-active-redacted.png`
- [ ] `03-activation-timeline.md`
- [ ] `TEST-RESULTS.md — active/eligible/duration/licensing`

## Repo deliverables

- `scripts/Export-LabRoles.ps1`
- `docs/labs/LAB-08.md`

## Exam trap

PIM eligibility is not equivalent to an active assignment. Azure RBAC roles and Entra directory roles have different scopes.

## Results / failure notes

Execution status: NOT TESTED

What worked:

What failed:

What I changed:

Where I would add production safeguards:

## Exact automation path

Run `./scripts/Export-LabRoles.ps1 -TenantId <private-guid>`. Scope: `RoleManagement.Read.Directory`. For PIM eligibility inspect `GET /roleManagement/directory/roleEligibilitySchedules` after granting appropriate read permission.

## Exact portal verification

Entra > Identity Governance > Privileged Identity Management; compare eligible vs active role states.
