# LAB-05 — Enterprise applications and SSO governance

**Week:** 05 · **Domain:** D3 · Workload identities (enterprise apps)
**Licence:** Core app registration/enterprise app exercises often work without P1; advanced provisioning and cloud app controls may require extras

**Outcome:** Explain and inventory the two-sided Entra application model with a fictional business app.

**Learn:** App registration vs enterprise application, service principal, SAML vs OIDC, app role assignments, consent and provisioning.

## Execute in order

1. Draw an app model: application object (definition) versus service principal (tenant instance); annotate client ID, object ID, scopes and app roles.
2. Create a fictional SC300-Expense-Portal app registration in your own tenant, preferably using Graph PowerShell New-MgApplication when permissions allow.
3. Locate corresponding enterprise application (service principal). Confirm the app ID is shared while the object IDs differ.
4. Set a friendly application description and configure a placeholder redirect URI only if you have a real safe local test app; avoid putting public production URLs into a fake app.
5. Create an SC300-Expense-Users group and document which app role users should have. Assign in a supported way for your test app or record the design if the feature needs licensing.
6. Inspect API permissions and describe delegated user permissions versus application permissions. Do not grant broad directory-write consent to an experimental app.
7. Run scripts/Export-LabApps.ps1; limit public output to SC300- named apps and counts, excluding secrets, identifiers and real service-principal objects.
8. Visit Entra > Enterprise applications and Entra > App registrations to verify corresponding objects and permission settings.
9. Write a one-page SSO decision note comparing SAML and OIDC, including token audience, certificates, claim mapping and rotation concerns.
10. Capture a redacted object comparison showing registration vs enterprise app and a consent review note.

## Tests you must run

- [ ] Positive: application and corresponding service principal are visible.
- [ ] Negative: app-only access is not assumed merely because an application is registered.
- [ ] Security: no client secret or certificate private key is exported to GitHub.

## Capture these exact artifacts

- [ ] `01-app-registration-redacted.png`
- [ ] `02-enterprise-app-redacted.png`
- [ ] `03-app-model.md and 04-permission-matrix.md`
- [ ] `TEST-RESULTS.md — registered vs tenant service-principal findings`

## Repo deliverables

- `scripts/Export-LabApps.ps1`
- `docs/labs/LAB-05.md`

## Exam trap

App registrations and enterprise applications are not the same resource; permissions requested are not automatically granted.

## Results / failure notes

Execution status: NOT TESTED

What worked:

What failed:

What I changed:

Where I would add production safeguards:

## Exact automation path

Run `./scripts/Export-LabApps.ps1 -TenantId <private-guid>`. Scope: `Application.Read.All`. For creating the fictional app use `New-MgApplication` after connecting with `Application.ReadWrite.All` and a suitable admin role.

## Exact portal verification

Entra > Applications > App registrations and Enterprise applications; compare app ID / object ID (keep values private).
