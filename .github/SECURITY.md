# Security Policy

## Supported Versions

| Version | Supported          |
|---------|--------------------|
| 1.x.x   | Yes (latest)       |
| < 1.0   | No (deprecated)    |

## Reporting a Vulnerability

**Jangan buka issue public untuk security vulnerability.**

Kalau kamu nemu security issue, tolong:

1. **Email** ke maintainer (lihat profile GitHub)
2. **Subject**: `[SECURITY] Xydesk RDP - deskripsi singkat`
3. **Include**:
   - Deskripsi vulnerability
   - Steps to reproduce
   - Potential impact
   - Suggested fix (kalau ada)

Response time: 1-3 hari.

## Security Best Practices

Kalau pakai project ini, ikutin ini:

1. **Jangan commit secrets** ke repo (token, password, API key)
2. **Pakai GitHub Secrets** untuk simpan credential
3. **Whitelist email** di Cloudflare Access (jangan "allow all")
4. **Ganti password RDP** setiap kali run workflow
5. **Pakai strong password** (min 12 char, alphanumeric + special)
6. **Monitor workflow logs** untuk aktivitas mencurigakan
7. **Jangan save data sensitif** di RDP (session cuma 6 jam, ephemeral)
8. **Update workflow** secara berkala untuk patch security

## Disclosure Timeline

- **Day 0**: Vulnerability di-report
- **Day 1-3**: Acknowledgment + initial assessment
- **Day 7-14**: Fix developed + tested
- **Day 14-21**: Patch released + disclosure

Kami appreciate responsible disclosure.
