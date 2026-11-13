# Screenshot and GitHub evidence procedure (Windows)

1. Confirm the object is synthetic: it begins `SC300-` or UPN local part `sc300-`.
2. Prepare Entra admin center on the specific object page. Hide navigation if unnecessary.
3. Press `Win + Shift + S`; capture only the controls that prove the result.
4. Paste into an editor that can apply irreversible redaction; COVER tenant IDs, UPNs, object IDs, subscription IDs, IPs, QR codes and any token/secret.
5. Save as `evidence/LAB-XX/01-description-redacted.png`. Reopen and zoom to check masks.
6. If terminal evidence is needed, hide `Connect-MgGraph` context output; print only result counts or anonymized labels before capture.
7. Generate sanitized JSON from purpose-built scripts. NEVER rename an unsanitized export and pretend it is sanitized.
8. Open the image and JSON again. Verify no identifying content remains.
9. Populate `docs/labs/LAB-XX.md`: link evidence, expected/actual tests, permissions and licence used.
10. Run `git status`, `git diff --cached`, `git grep` for own UPN and tenant suffix, then commit.
11. Confirm on GitHub after push that diagrams, images and links render correctly.
12. Record what was not tested: a screenshot alone is not end-to-end validation.

Command sequence:
```
git checkout -b lab-xx
git add scripts policies docs evidence
git diff --cached --stat
git diff --cached
git commit -m "lab(xx): document verified IAM scenario"
git push -u origin lab-xx
```

Open a Pull Request, review checks and merge. Do not store PFX files or secrets in the repository, even temporarily: Git history persists.
