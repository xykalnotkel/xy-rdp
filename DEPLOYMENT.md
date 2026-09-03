# Xydesk RDP - Deployment Info

## Live Status

- **Repo**: https://github.com/xykalnotkel/xy-rdp
- **Domain**: `rdp.xyc.my.id`
- **Tunnel**: `xydesk-rdp` (reused from existing)
- **RDP Port**: 13389
- **User**: Xydesk

## How to Run

1. Buka: https://github.com/xykalnotkel/xy-rdp/actions
2. Klik workflow "Xydesk Windows RDP" (kalau belum running)
3. Klik "Run workflow" dengan input:
   - Password: (pilih sendiri, min 8 char)
   - Duration: 6 jam (max)
   - RDP Port: 13389

## How to Connect

Setelah workflow selesai (~5-10 menit):

1. Buka: **https://rdp.xyc.my.id** di browser
2. Login dengan RDP client:
   - PC name: `rdp.xyc.my.id:13389`
   - User: `Xydesk`
   - Password: (yang kamu set di workflow)
3. Atau pakai Microsoft Remote Desktop app

## Secrets Configured (di GitHub)

| Secret | Value |
|--------|-------|
| `CLOUDFLARE_TUNNEL_TOKEN` | Token dari tunnel `xydesk-rdp` |
| `CLOUDFLARE_TUNNEL_ID` | `e5a6443d-a2a6-4e66-b2e2-7980c815c94c` |

## Cloudflare Setup Done

- Tunnel: `xydesk-rdp` (existing, reused)  
- DNS: `rdp.xyc.my.id` -> tunnel CNAME (proxied)
- Config: ingress route to `rdp://localhost:13389`
