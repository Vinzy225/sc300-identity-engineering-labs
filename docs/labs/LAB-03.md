# LAB-03 — Passwordless, MFA and Conditional Access

**Week:** 03 · **Domain:** D2 · Authentication and access
**Licence:** P1 for Conditional Access; P2 for risk-based conditions; passkeys availability depends on tenant policy

**Outcome:** Deploy a report-only MFA policy to one test group, without risking lockout.

**Learn:** Authentication method policy, Temporary Access Pass, phishing-resistant methods, report-only Conditional Access, emergency access.

## Execute in order

1. Create a separate emergency-access account and document recovery access in private notes. Exclude it explicitly from your lab Conditional Access policy. Do not publish its UPN.
2. Create a group named SC300-CA-Pilot and add only a synthetic test user; do not include your daily admin account.
3. Confirm tenant has P1 and Conditional Access is available. Review Security Defaults behavior; never toggle authentication protections in a production tenant for a lab.
4. Read policies/ca-report-only.example.json and identify includeGroups, excludeUsers, grantControls and state. Explain why report-only is not enforcement.
5. Run scripts/New-LabReportOnlyCA.ps1 without -Execute and inspect the planned policy scope. Supply PilotGroupId and BreakGlassUserId as runtime parameters, not committed values.
6. Run again with -Execute after confirming the policy is restricted to the test group and enabledForReportingButNotEnforced. Record created policy ID privately.
7. In Entra > Protection > Conditional Access review the new policy. Confirm report-only state, included pilot group and excluded emergency account.
8. Use Conditional Access What If with the pilot test user. Generate a test sign-in and inspect the sign-in log when licensing permits; note processing delays.
9. Run scripts/Export-LabCAPolicies.ps1 to produce a restricted, redacted list of SC300- prefixed policy names and states. Do not publish raw conditions with principal IDs.
10. Document decision table: target user → included → excluded? → policy state → expected access. Capture both policy configuration and verification.

## Tests you must run

- [ ] Positive: exactly one test policy exists in report-only and the intended test group is in scope.
- [ ] Negative: the emergency account is excluded; verify via What If.
- [ ] Safety: no enabled (enforced) lab CA policy after the exercise.

## Capture these exact artifacts

- [ ] `01-policy-state-redacted.png — report-only state visible`
- [ ] `02-what-if-redacted.png — target and exclusions sanitized`
- [ ] `03-graph-policy-summary.json — safe SC300- policy names/state`
- [ ] `TEST-RESULTS.md — scope check, exclusions, expected effect`

## Repo deliverables

- `scripts/Export-LabCAPolicies.ps1`
- `scripts/New-LabReportOnlyCA.ps1`
- `policies/ca-report-only.example.json`

## Exam trap

Report-only policies do not enforce MFA; security defaults and Conditional Access require deliberate configuration planning.

## Results / failure notes

Execution status: NOT TESTED

What worked:

What failed:

What I changed:

Where I would add production safeguards:

## Exact automation path

Run `./scripts/New-LabReportOnlyCA.ps1 -TenantId <private-guid> -PilotGroupId <private-guid> -BreakGlassUserId <private-guid>` in plan mode; only then add `-Execute`. Scopes: `Policy.Read.All` and `Policy.ReadWrite.ConditionalAccess`.

## Exact portal verification

Entra > Protection > Conditional Access > Policies and What If; check state = Report-only and exclusion.
