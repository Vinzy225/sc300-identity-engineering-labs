# LAB-10 — Audit evidence, KQL and SC-300 exam readiness

**Week:** 10 · **Domain:** D1–D4 · Integrative exam practice
**Licence:** Log Analytics Azure costs can apply; Graph directory audit availability differs from sign-in reporting

**Outcome:** Produce an auditable troubleshooting case and close remaining exam objectives.

**Learn:** Sign-in vs audit logs, diagnostic settings, workbooks, Identity Secure Score, basic KQL, exam objective-gap review.

## Execute in order

1. Take an official practice assessment and list every missed question under the CURRENT SC-300 domain, not just the module title from the older learning paths.
2. Create a test change in Entra (for example, update a synthetic user department). Record planned start and expected log event.
3. Use Graph to retrieve relevant directory audit events and export to local-only/. Validate the event timestamp and target object.
4. If your Azure subscription allows it, create a small Log Analytics workspace with daily cap/cost controls; configure a limited diagnostic stream and remove it after validation.
5. Write three KQL queries to identify failed sign-ins, role-change operations and application credential changes; adjust schema to the actual tables available.
6. Compare security logs with the read-only Graph and Entra portal view; identify different retention and ingestion delay behavior.
7. Create a sample incident record with detection, investigation, root cause, severity, remediation and verification.
8. Study the four domain gaps and any topics not naturally covered by your labs, including Global Secure Access and Defender for Cloud Apps concepts.
9. Run the current Microsoft practice assessment again using fresh questions; do not treat familiarity with repeated questions as exam mastery.
10. Create a one-page exam readiness summary and optionally schedule the exam only if ready.

## Tests you must run

- [ ] Positive: a known change appears in audit logs within observed latency.
- [ ] Negative: missing logs are diagnosed as licence, scope, role, retention, delay or disabled ingestion—not assumed lost.
- [ ] Readiness: articulate why each incorrect practice answer was wrong.

## Capture these exact artifacts

- [ ] `01-audit-timeline-redacted.png`
- [ ] `02-kql-query-examples.md`
- [ ] `03-exam-gap-register.md (no copyrighted questions)`
- [ ] `TEST-RESULTS.md — audit and KQL findings`

## Repo deliverables

- `scripts/Export-LabSignIns.ps1`
- `docs/labs/LAB-10.md`

## Exam trap

Audit logs and sign-in logs differ; the existence of logs does not imply they were exported into Log Analytics.

## Results / failure notes

Execution status: NOT TESTED

What worked:

What failed:

What I changed:

Where I would add production safeguards:

## Exact automation path

Run `./scripts/Export-LabAuditEvents.ps1 -TenantId <private-guid> -Hours 24`. Scope: `AuditLog.Read.All`. For Azure Log Analytics use KQL in the workspace and monitor ingestion costs.

## Exact portal verification

Entra > Monitoring & health > Audit logs; compare activity type and approximate time.
