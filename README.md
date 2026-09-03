# Xydesk RDP - Custom Cloud Desktop via GitHub Actions

[![Windows RDP](https://img.shields.io/badge/Windows-Server%202022-0078D6?style=for-the-badge&logo=windows&logoColor=white)](https://github.com/your-username/xy-rdp)
[![License](https://img.shields.io/github/license/your-username/xy-rdp?style=for-the-badge)](LICENSE)
[![GitHub stars](https://img.shields.io/github/stars/your-username/xy-rdp?style=for-the-badge)](https://github.com/your-username/xy-rdp/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/your-username/xy-rdp?style=for-the-badge)](https://github.com/your-username/xy-rdp/network)
[![GitHub issues](https://img.shields.io/github/issues/your-username/xy-rdp?style=for-the-badge)](https://github.com/your-username/xy-rdp/issues)
[![Maintained](https://img.shields.io/badge/Maintained-yes-green?style=for-the-badge)](https://github.com/your-username/xy-rdp)
[![Made with Love](https://img.shields.io/badge/Made%20with-Love-red?style=for-the-badge)](https://github.com/your-username/xy-rdp)

> RDP Windows Server gratis via GitHub Actions, dikustomisasi dengan user `Xydesk`, domain Cloudflare, dan pre-installed dev environment terbaru.

---

## Daftar Isi

- [Fitur](#fitur)
- [Quick Start](#quick-start)
- [Setup Cloudflare Tunnel](#setup-cloudflare-tunnel)
- [Setup GitHub Secrets](#setup-github-secrets)
- [Menjalankan RDP](#menjalankan-rdp)
- [Customization](#customization)
- [Security](#security)
- [Troubleshooting](#troubleshooting)
- [Resource Limits](#resource-limits)
- [Tips](#tips)
- [Lisensi](#lisensi)

---

## Fitur

- **Custom user**: `Xydesk` dengan akses admin full
- **Password custom** (ganti setiap run via input workflow)
- **Domain sendiri** via Cloudflare Tunnel (HTTPS + Google login)
- **Pre-installed dev environment** (semua versi terbaru per Sept 2026):
  - Node.js 24 LTS, Python 3.13, Go 1.25, Rust 1.91, Java 25, .NET 9
  - PHP 8.4, Ruby 3.4, TypeScript, C++ Build Tools, CMake
  - Visual Studio Code + extensions (Python, C++, Rust, Go, Java, .NET, Continue AI, Cline)
  - Git, GitHub CLI, Docker Desktop
  - Chrome, Postman, 7-Zip
  - Ollama + LLMs (llama3.2, qwen2.5-coder) - opsional
- **Custom branding**: wallpaper, taskbar, dark theme
- **Security**: TLS 1.3 RDP, firewall, account lockout, audit log
- **Session 1-6 jam** (max GitHub Actions limit)

## Tech Stack

[![Node.js](https://img.shields.io/badge/Node.js-24_LTS-339933?style=flat-square&logo=nodedotjs&logoColor=white)](https://nodejs.org)
[![Python](https://img.shields.io/badge/Python-3.13-3776AB?style=flat-square&logo=python&logoColor=white)](https://python.org)
[![Java](https://img.shields.io/badge/Java-25_LTS-ED8B00?style=flat-square&logo=openjdk&logoColor=white)](https://openjdk.org)
[![Go](https://img.shields.io/badge/Go-1.25-00ADD8?style=flat-square&logo=go&logoColor=white)](https://go.dev)
[![Rust](https://img.shields.io/badge/Rust-1.91-000000?style=flat-square&logo=rust&logoColor=white)](https://rust-lang.org)
[![.NET](https://img.shields.io/badge/.NET-9-512BD4?style=flat-square&logo=dotnet&logoColor=white)](https://dotnet.microsoft.com)
[![VS Code](https://img.shields.io/badge/VS_Code-Latest-007ACC?style=flat-square&logo=visualstudiocode&logoColor=white)](https://code.visualstudio.com)
[![Docker](https://img.shields.io/badge/Docker-Latest-2496ED?style=flat-square&logo=docker&logoColor=white)](https://docker.com)
[![Cloudflare](https://img.shields.io/badge/Cloudflare-Tunnel-F38020?style=flat-square&logo=cloudflare&logoColor=white)](https://cloudflare.com)

## Quick Start

### 1. Fork Repository Ini

Klik **Fork** di pojok kanan atas halaman ini.

### 2. Setup Cloudflare Tunnel (Recommended)

Lihat [panduan lengkap](./docs/SETUP-GUIDE.md) atau ringkasan di bawah.

**Cara paling aman biar login Google dianggap legitimate:**

#### A. Setup Domain & Tunnel

1. **Daftar Cloudflare** (gratis): https://dash.cloudflare.com/sign-up
2. **Tambah domain** kamu (atau beli baru, contoh: `xydev.id`)
3. **Buat Tunnel**:
   - Buka https://one.dash.cloudflare.com/
   - Pilih **Networks** > **Tunnels** > **Create a tunnel**
   - Name: `xydesk-rdp`
   - **Save tunnel** > **Copy token** (simpan baik-baik!)

#### B. Konfigurasi Public Hostname

1. Di tunnel yang baru dibuat, klik **Configure**
2. Tab **Public Hostname** > **Add a public hostname**
3. Isi:
   - **Subdomain**: `rdp`
   - **Domain**: `yourdomain.com` (punya kamu)
   - **Service**: Type: `RDP`, URL: `localhost:13389`
4. **Save**

#### C. Setup Google OAuth (Biar Aman!)

1. **Google Cloud Console**: https://console.cloud.google.com/
2. Buat project baru (misal: `Xydesk`)
3. **APIs & Services** > **OAuth consent screen**:
   - User type: **External**
   - App name: `Xydesk RDP`
   - Support email: email kamu
   - Scopes: `email`, `profile`, `openid`
   - **Save**
4. **Credentials** > **Create OAuth client ID**:
   - Type: **Web application**
   - Name: `Xydesk Cloudflare`
   - Authorized redirect URIs:
     ```
     https://yourdomain.com/cdn-cgi/access/callback
     https://<your-team-name>.cloudflareaccess.com/cdn-cgi/access/callback
     ```
   - **Create** > Copy **Client ID** & **Client Secret**

5. **Cloudflare Zero Trust**:
   - Settings > **Authentication** > **Add new**
   - Name: `Google`
   - Type: **Google**
   - Paste Client ID & Client Secret
   - **Save**

#### D. Protect Tunnel dengan Access Policy

1. **Access** > **Applications** > **Add application**
2. Type: **Self-hosted**
3. Isi:
   - Name: `Xydesk RDP`
   - Domain: `rdp.yourdomain.com`
   - Session duration: `24 hours`
4. **Next** > Policy:
   - Name: `Allow My Email`
   - Action: **Allow**
   - Include > **Emails** > masukkan email kamu
5. **Save**

### 3. Setup GitHub Secrets

Pergi ke repo kamu > **Settings** > **Secrets and variables** > **Actions** > **New repository secret**

Tambahkan:

| Secret Name | Value |
|-------------|-------|
| `CLOUDFLARE_TUNNEL_TOKEN` | Token dari Step 2A |
| `CLOUDFLARE_TUNNEL_ID` | ID tunnel dari Cloudflare |
| `TAILSCALE_AUTH_KEY` | (Opsional) dari https://login.tailscale.com/admin/settings/keys |

### 4. Run Workflow

1. Buka tab **Actions** di repo kamu
2. Pilih **Xydesk Windows RDP**
3. Klik **Run workflow**
4. Isi input:
   - **Password**: password kuat kamu (misal: `MyXydesk2026!`)
   - **Duration**: 6 (jam, max)
   - **RDP Port**: 13389 (default, atau ganti)
   - **Install AI tools?**: Yes (Ollama)
   - **Install Docker?**: Yes
5. Klik **Run workflow**
6. **Tunggu 5-10 menit** sampai setup selesai

### 5. Login ke RDP

#### Cara 1: Via Browser (Recommended, paling aman)

1. Buka **https://rdp.yourdomain.com** di browser
2. Login dengan **akun Google** kamu (aman, via Cloudflare Access)
3. Otomatis connect ke RDP Windows

#### Cara 2: Via Microsoft Remote Desktop App

1. Download **Microsoft Remote Desktop**:
   - Windows: https://aka.ms/rdclient
   - Mac: App Store > cari "Microsoft Remote Desktop"
   - Android/iOS: Play Store / App Store > cari "RD Client"
2. Add PC:
   - **PC name**: `rdp.yourdomain.com:13389`
   - **User account**: `Xydesk`
   - **Password**: yang kamu set di workflow
3. Connect!

#### Cara 3: Langsung (paling simple, kurang aman)

1. Lihat **workflow logs** > step **Get connection info**
2. Copy **IP address** & **port**
3. Connect dari RDP client

## Customization

### Ganti Password

Edit di workflow input saat run, atau hardcode di `.github/workflows/windows-rdp.yml`:

```yaml
DESKTOP_PASSWORD: 'PasswordKamuDisini!2026'
```

### Tambah Software

Edit step **Install browsers + dev tools**, tambahkan command install.

### Ganti Domain

Edit di Cloudflare Dashboard > Tunnel config:

```yaml
# Cloudflare Tunnel config
Service: rdp://localhost:13389
Subdomain: rdp
Domain: yourdomain.com
```

### Auto-shutdown

Default 6 jam. Bisa diubah di workflow input:

```yaml
duration:
  default: '4'  # 4 jam
```

## Security

### Kenapa Pakai Cloudflare Tunnel?

- **Login Google = legitimate** (ga dianggap mencurigakan sama Cloudflare/GitHub)
- **HTTPS otomatis** (ga perlu setup cert)
- **Ga perlu buka port** di router/firewall
- **DDoS protection** built-in
- **Access control** - cuma email tertentu yang bisa login

### Security Hardening yang Sudah Included

- TLS 1.3 untuk RDP
- Non-standard port (13389, bukan 3389)
- Account lockout setelah 5x gagal login
- Audit logging enabled
- SMBv1 disabled
- Windows Defender aktif
- Firewall rules strict
- Default `runneradmin` user disabled

### Rekomendasi Tambahan

- **Ganti password** setiap kali run workflow
- **Pakai Cloudflare Access** (jangan langsung expose IP)
- **Whitelist email** di Access Policy (jangan "allow all")
- **Monitor logs** di workflow run history
- **Jangan lupa stop** workflow kalau udah selesai (auto-stop 6 jam)

## Troubleshooting

### RDP ga bisa connect

- Cek workflow **sudah selesai** setup (jangan crash)
- Lihat **Get connection info** step untuk IP & port
- Pastikan pakai **port** yang benar (bukan default 3389)
- Coba **restart workflow** (kadang GitHub runner ada masalah)

### "Login mencurigakan" di Google

- Pastikan OAuth consent screen **sudah verified** (bisa minta Google)
- Jangan pake **personal account** untuk OAuth app production
- Pake **Workspace account** kalau punya

### Cloudflare tunnel error

- Cek **token** masih valid (regenerate kalau perlu)
- Pastikan **subdomain** belum dipake orang lain
- Cek **DNS propagation** (bisa 24 jam)

### VS Code ga bisa dibuka

- Klik kanan desktop > **Refresh**
- Atau run dari Start Menu > **Visual Studio Code**

## Resource Limits

| Resource | Limit (GitHub Free) |
|----------|---------------------|
| CPU | 4 cores |
| RAM | 16 GB |
| Storage | 14 GB SSD |
| Network | 1 Gbps |
| Session | 6 jam max |
| Minutes/month | 2000 (private) / unlimited (public) |

## Tips

1. **Buat repo PUBLIC** biar dapet unlimited minutes
2. **Workflow run cepat expire** (6 jam), jangan lupa save kerjaan ke cloud
3. **Pakai Git di dalam RDP** buat sync code ke repo kamu
4. **Gunakan Tailscale** untuk akses file dari PC lokal
5. **Pasang password manager** (Bitwarden) di RDP untuk simpan credential

## Kontribusi

PR welcome! Tambahin tools, optimasi setup, atau fix bug.

Lihat [CONTRIBUTING.md](.github/CONTRIBUTING.md) untuk panduan.

## Lisensi

[MIT](LICENSE) - bebas dipake, dimodifikasi, disebarkan.

---

**Made with dedication by Xydesk Community**

*Powered by GitHub Actions + Cloudflare Zero Trust*
