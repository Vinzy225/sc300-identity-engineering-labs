# LAB-04 — Risk, authentication methods and sign-in investigation

**Week:** 04 · **Domain:** D2 · Authentication and access
**Licence:** P2 for ID Protection risk policies; P1/P2 for many sign-in report scenarios

**Outcome:** Investigate test sign-in behavior and produce a privacy-safe incident report.

**Learn:** User risk vs sign-in risk, Temporary Access Pass, passkeys, SSPR, authentication strengths, Global Secure Access overview.

## Execute in order

1. Build a matrix comparing user risk, sign-in risk, blocked sign-ins, MFA registration gaps and Conditional Access failures. State which features require P2.
2. Configure a lab authentication method policy (for example, Microsoft Authenticator or TAP if allowed). Keep a separate emergency path and do not reset your only admin authentication method.
3. Create two test scenarios: successful synthetic user sign-in and a deliberately denied session by attempting a blocked app or wrong credentials in a test-safe way.
4. Run scripts/Export-LabSignIns.ps1 with -Hours 24 and an output path under local-only/. If Graph logs are not licensed, use documented mock output and mark it simulated.
5. Inspect status, failure reason, client app, Conditional Access status and timestamp. Do not export IPs or UPNs into public evidence.
6. Visit Entra > Monitoring & health > Sign-in logs; filter the test account and compare the corresponding event to the Graph result.
7. Use Graph or portal to inspect authentication methods for one synthetic user under permitted roles; document method registration and supported role boundaries.
8. Explain in writing when self-service password reset differs from forced password reset and how Conditional Access interacts with the sign-in process.
9. Create a short sanitized investigation timeline with event type, timestamps relative to test start and your inference; avoid copying raw token claims or client IP data.
10. Write two exam-trap flashcards: user risk vs sign-in risk; Conditional Access vs authentication method policy.

## Tests you must run

- [ ] Positive: expected successful test sign-in appears when reports are licensed.
- [ ] Negative: denied authentication generates a distinct status/error and is not misdiagnosed as an authorization issue.
- [ ] Fallback: mock data is labelled SIMULATED rather than presented as production evidence.

## Capture these exact artifacts

- [ ] `01-sign-in-redacted.png — relevant event without UPN/IP`
- [ ] `02-sign-in-summary.csv — synthetic or safe aggregate`
- [ ] `03-investigation-timeline.md — time, status, interpretation`
- [ ] `TEST-RESULTS.md — data source and feature/licence status`

## Repo deliverables

- `scripts/Export-LabSignIns.ps1`
- `docs/labs/LAB-04.md`

## Exam trap

Graph audit and sign-in permissions plus the correct Entra role (and licence) may all be required.

## Results / failure notes

Execution status: NOT TESTED

What worked:

What failed:

What I changed:

Where I would add production safeguards:

## Exact automation path

Run `./scripts/Export-LabSignIns.ps1 -TenantId <private-guid> -Hours 24`. Scope: `AuditLog.Read.All` and proper reader role; add `Policy.Read.ConditionalAccess` if applied policy detail is needed.

## Exact portal verification

Entra > Monitoring & health > Sign-in logs; compare event count and status.
