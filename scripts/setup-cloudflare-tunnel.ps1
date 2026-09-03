# ===========================================
#  Cloudflare Tunnel Setup Helper
#  Buat dapet domain sendiri + Google login
# ===========================================

<#
.SYNOPSIS
    Helper script untuk setup Cloudflare Tunnel + Google OAuth untuk Xydesk RDP.

.DESCRIPTION
    Step-by-step guide untuk konfigurasi Cloudflare Zero Trust dengan:
    - Custom tunnel untuk RDP traffic
    - Google OAuth integration
    - Access policy untuk whitelist email

.NOTES
    File ini hanya dokumentasi. Ikutin step-by-step di Cloudflare Dashboard
    dan Google Cloud Console.
#>

# ============================================
# Step 1: Login ke Cloudflare Dashboard
# ============================================
# https://dash.cloudflare.com/

# ============================================
# Step 2: Setup Zero Trust
# ============================================
# https://one.dash.cloudflare.com/

# ============================================
# Step 3: Create Tunnel
# ============================================
#   - Zero Trust > Networks > Tunnels > Create tunnel
#   - Name: xydesk-rdp
#   - Save tunnel token

# ============================================
# Step 4: Configure Public Hostname
# ============================================
#   - Subdomain: rdp
#   - Domain: yourdomain.com
#   - Service: rdp://localhost:13389
#   - Save

# ============================================
# Step 5: Setup Google OAuth (biar login Google = safe, bukan mencurigakan)
# ============================================
#   - Zero Trust > Settings > Authentication > Add new
#   - Name: Google Workspace
#   - Type: Google
#   - Client ID: [dari Google Cloud Console]
#   - Client Secret: [dari Google Cloud Console]
#   - Email: email yang dibolehin login (opsional)

# ============================================
# Step 6: Add Access Policy
# ============================================
#   - Zero Trust > Access > Applications > Add application
#   - Name: Xydesk RDP
#   - Domain: rdp.yourdomain.com
#   - Policy: Allow > Emails > [email kamu]
#   - Save

# ============================================
# CARA PAKAI DI GITHUB ACTIONS:
# ============================================

# 1. Add secrets di GitHub repo:
#    Settings > Secrets and variables > Actions > New repository secret
#
#    CLOUDFLARE_TUNNEL_TOKEN  -> dari Step 3
#    CLOUDFLARE_TUNNEL_ID     -> ID tunnel kamu
#    TAILSCALE_AUTH_KEY       -> opsional, buat private network

# 2. Run workflow di GitHub:
#    Actions > Xydesk Windows RDP > Run workflow

# 3. Akses RDP:
#    - Buka: https://rdp.yourdomain.com
#    - Login pakai Google (aman, karena via Cloudflare Access)
#    - RDP credentials di workflow log

# ============================================
# ALTERNATIF: Tanpa Cloudflare (IP langsung)
# ============================================

# Pake Tailscale (private network, ga ada port forwarding):
#   1. Daftar: https://tailscale.com/
#   2. Generate auth key: https://login.tailscale.com/admin/settings/keys
#   3. Add TAILSCALE_AUTH_KEY ke GitHub Secrets
#   4. RDP pake: [tailscale-ip]:13389

Write-Host "This is a documentation file. See comments above for setup instructions."
