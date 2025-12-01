# Compliance & Risk Checklist (baseline)

This project is not a certified medical device; for regulated use, align with applicable frameworks (HIPAA/GDPR/ISO 27001). This checklist tracks readiness items.

## Data & Privacy
- [ ] Define data classification (PII/PHI) and retention; document data flows.
- [ ] Ensure HTTPS/TLS everywhere; no plaintext credentials.
- [ ] Implement consent flows and privacy policy updates with versioning.
- [ ] Log redaction: no PII/PHI in logs; scrub tokens and request bodies.

## Security Controls
- [ ] Secrets in GitHub Actions secrets only; rotate periodically.
- [ ] Dependency scanning (Dependabot/Renovate + vulnerability audit).
- [ ] Secret scanning (gitleaks) and SAST (CodeQL/Dart Code Metrics) wired in CI.
- [ ] SBOM generated per build and attached to artifacts.
- [ ] AuthN/Z strategy (token storage, refresh, session timeout) defined; consider device pinning.
- [ ] Cert pinning or trust policy for API hosts.

## Quality & Reliability
- [ ] Coverage gate >=90% enforced in CI.
- [ ] Lint gate for banned APIs (`print`, `http://`, TODOs without owners).
- [ ] Incident runbook and escalation matrix.
- [ ] Backups/versioning for dependencies and artifacts.

## Operational
- [ ] CODEOWNERS, PR/issue templates, branch protection rules.
- [ ] Release notes and change management (semantic versioning / changelog).
- [ ] Monitoring/observability plan (crash reporting, performance, audit trails).

Use this checklist during readiness reviews; mark items complete with links to evidence.
