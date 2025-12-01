# Security Policy

## Reporting
- Report vulnerabilities privately via GitHub Security Advisories or email security@allingaming.com.
- Do not open public issues for sensitive reports.

## Expectations
- We respond within 5 business days.
- We coordinate public disclosure timelines as needed.

## Scope
- All code and workflows in this repository.
- Secrets should never be committed; CI runs gitleaks to detect accidental leaks.

## Safe practices
- Prefer HTTPS everywhere; no plaintext credentials.
- Rotate tokens regularly and store secrets in GitHub Actions secrets only.
