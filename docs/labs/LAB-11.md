# LAB-11 — Intune and Autopilot engineering extension

**Week:** 11 · **Domain:** PORTFOLIO ONLY · MD-102 skills (outside SC-300 core)
**Licence:** Intune entitlement required; physical-device zero-touch validation needs suitable hardware and enrollment readiness

**Outcome:** Build an automated device provisioning design and validate only the parts you actually deploy.

**Learn:** Intune enrollment, Autopilot deployment profiles, device groups, compliance, Entra join and Conditional Access dependency.

## Execute in order

1. Document hardware prerequisites and choose either genuine Windows 11 device testing or policy-only validation. A policy screenshot is not proof of zero-touch enrollment.
2. Create SC300-Autopilot-Pilot device group via supported Graph group operations; avoid assigning to broad production groups.
3. Use the Microsoft Graph deviceManagement endpoint to list available enrollment profiles and configuration templates after confirming relevant Graph permissions and licences.
4. Create or adapt a test Autopilot deployment profile using supported Intune UI or API, recording profile mode and target device group.
5. Configure one harmless compliance policy and assignment; export public-safe policy intent without real policy IDs or device serials.
6. If hardware available, register device with allowed corporate ownership, complete Out-of-box experience and capture Enrollment Status Page outcome; else state NOT PHYSICALLY VALIDATED.
7. Verify device registration, Intune managed device status, compliance and policy assignment via Graph and admin centers.
8. Test a policy misassignment or compliance failure without weakening baseline protections; document troubleshooting flow.
9. Draw identity-to-device-to-Conditional-Access trust chain and explain what is Entra registration, join, hybrid join and Intune management.
10. Publish process diagram, sanitized device-policy summary, actual validation status and limitations.

## Tests you must run

- [ ] Positive: target device/policy association is correct when license/hardware available.
- [ ] Negative: unassigned device should not receive pilot profile.
- [ ] Truthfulness: separate deployed configuration from end-to-end OOBE proof.

## Capture these exact artifacts

- [ ] `01-autopilot-deployment-flow.png`
- [ ] `02-policy-assignment-redacted.png`
- [ ] `03-enrollment-result-redacted.png or NOT-TESTED.md`
- [ ] `TEST-RESULTS.md — device, policy, compliance`

## Repo deliverables

- `docs/labs/LAB-11.md`
- `docs/architecture/autopilot.md`

## Exam trap

Autopilot enrolment, Entra join and Intune compliance are distinct components and are not themselves SC-300 objectives.

## Results / failure notes

Execution status: NOT TESTED

What worked:

What failed:

What I changed:

Where I would add production safeguards:

## Exact automation path

Run `./scripts/Export-LabIntuneSummary.ps1 -TenantId <private-guid>`. Scope: `DeviceManagementManagedDevices.Read.All`. For configuration writes use corresponding Graph deviceManagement endpoints with scoped permission and Intune role.

## Exact portal verification

Intune admin center > Devices > Windows enrollment / Compliance; verify real policy assignment; physical test separately.
