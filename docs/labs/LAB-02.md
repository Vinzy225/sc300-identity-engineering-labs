# LAB-02 — Joiner–Mover–Leaver lifecycle

**Week:** 02 · **Domain:** D1 · Manage user identities
**Licence:** Entra Free for basic user/group lifecycle; group-based licensing and dynamic groups may require P1

**Outcome:** Turn a fictional HR intake row into a controlled, audit-friendly user lifecycle process.

**Learn:** Cloud-only identity lifecycle, group assignment, idempotency, change approval, group-based licensing concept.

## Execute in order

1. Copy sample-data/joiners.csv and update only the fictional alias, display name and department fields; keep domain as an input parameter rather than embedding your tenant suffix in source.
2. Define the expected state: new user enabled, department set, forced password reset, approved group membership; mover updates department and removes unneeded access; leaver is disabled but not deleted.
3. Open scripts/New-LabJoiner.ps1. Review param block and the -Execute safety switch; confirm the script rejects aliases that do not begin sc300-.
4. Run the script without -Execute to inspect the plan. The output should show the proposed UPN and explicitly state NO CHANGE.
5. Execute against a personal tenant using -Execute. Enter a temporary password interactively. Confirm it is not written to any log or repository file.
6. In Entra > Users select the synthetic user and check department, enabled status and sign-in name. Query the same properties with Get-MgUser and compare.
7. Run the script with identical inputs a second time. Expected: existing account recognized and not duplicated. Save an idempotency test note.
8. Simulate a department transfer through an approved update in Graph PowerShell. Record the before/after department and group membership in sanitized form.
9. Run scripts/Disable-LabLeaver.ps1 first without -Execute, then with -Execute against the exact synthetic UPN. Verify accountEnabled = false through read-only Graph.
10. Write an operations runbook describing HR approval, eventual licensing changes, recovery, data retention and what must never happen automatically (permanent deletion).

## Tests you must run

- [ ] Positive: exactly one account exists after two provisioning runs.
- [ ] Negative: the leaver command rejects UPNs without the sc300- prefix.
- [ ] Rollback: re-enable only your synthetic test user through a deliberate, documented administrator action.

## Capture these exact artifacts

- [ ] `01-provision-plan.png — dry-run with no real tenant ID`
- [ ] `02-user-before-after.png — redacted user properties`
- [ ] `03-idempotency-test.txt — second run resulted in SKIP`
- [ ] `TEST-RESULTS.md — creation, mover, disable and recovery checks`

## Repo deliverables

- `scripts/New-LabJoiner.ps1`
- `scripts/Disable-LabLeaver.ps1`
- `sample-data/joiners.csv`

## Exam trap

Disabling a user, revoking refresh tokens, removing groups and preserving content are separate lifecycle operations.

## Results / failure notes

Execution status: NOT TESTED

What worked:

What failed:

What I changed:

Where I would add production safeguards:

## Exact automation path

Plan `./scripts/New-LabJoiner.ps1 -TenantId <private-guid> -Alias sc300-alex -DisplayName "SC300-Alex Example" -Department Finance -UpnDomain <tenant>.onmicrosoft.com`. Add `-Execute` only after review. Scope: `User.ReadWrite.All`. Leaver script uses the same scope.

## Exact portal verification

Entra > Identity > Users > synthetic account > Properties; compare accountEnabled through Get-MgUser.
