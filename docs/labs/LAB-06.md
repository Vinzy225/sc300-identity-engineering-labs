# LAB-06 — Unattended workload identity and secure API access

**Week:** 06 · **Domain:** D3 · Workload identities
**Licence:** Core app registrations available in basic tenants; managed identity experiments need an Azure subscription and sometimes incur costs

**Outcome:** Design an unattended read-only inventory job using a dedicated service principal.

**Learn:** Managed identity, certificates vs client secrets, delegated vs application access, app-only consent, Azure resource identity.

## Execute in order

1. Start from your LAB-05 application model and create a separate SC300-Inventory-Agent app registration so the intended permission boundary is clear.
2. Create a short-lived self-signed public certificate in Windows certificate store for lab only; keep its private key local and never export a PFX into the repo.
3. Attach only the public certificate to the application; request one necessary application permission (for example User.Read.All) and obtain explicit admin consent in the lab.
4. Compare the delegated interactive command and certificate-based app-only Connect-MgGraph. Record why application permissions lack the end-user context.
5. Run a read-only inventory with the app-only identity and save a private execution log showing app name, timestamp, count and status.
6. Remove one permission or use an underprivileged test application; verify that expected 403/insufficient-privilege is handled and diagnosed.
7. Draw a decision matrix: local certificate, Azure managed identity, and GitHub OIDC federation. Choose based on where the automation actually runs.
8. If you have Azure credits, deploy a minimal test Azure resource with system-assigned managed identity, check its principal, then delete the resource to stop charges.
9. Document certificate rotation, app owner, monitoring and revocation playbook; never assume a one-off certificate is production-ready.
10. Publish a sanitized architecture diagram and a permissions matrix; do not publish any live authentication material.

## Tests you must run

- [ ] Positive: app-only token permits only approved read operations.
- [ ] Negative: underprivileged app receives denied response; record root cause.
- [ ] Revocation: demonstrate how an app role grant or certificate would be removed (design or lab test).

## Capture these exact artifacts

- [ ] `01-workload-identity-architecture.png`
- [ ] `02-app-permission-grants-redacted.png`
- [ ] `03-read-only-success-and-deny.md`
- [ ] `TEST-RESULTS.md — permissions, authentication modes, key hygiene`

## Repo deliverables

- `docs/labs/LAB-06.md`
- `docs/architecture/workload-identity.md`

## Exam trap

Managed identities apply to supported Azure workloads; a desktop scheduled task is not automatically a managed identity.

## Results / failure notes

Execution status: NOT TESTED

What worked:

What failed:

What I changed:

Where I would add production safeguards:

## Exact automation path

Use `Connect-MgGraph -TenantId <private-guid> -ClientId <private-app-guid> -CertificateThumbprint <local-thumbprint>` after admin-consenting *application* permission `User.Read.All`; this is app-only, so no `-Scopes` in the connection call. SDK read operation: `Get-MgUser -All`.

## Exact portal verification

Entra > App registrations > API permissions / Certificates & secrets; verify public certificate and app permission grant.
