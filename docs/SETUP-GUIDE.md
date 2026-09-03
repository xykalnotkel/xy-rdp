# Detailed Setup Guide

Panduan lengkap step-by-step untuk setup Xydesk RDP.

## Daftar Isi

- [Part 1: Setup Akun & Repo](#part-1-setup-akun--repo-5-menit)
- [Part 2: Setup Cloudflare](#part-2-setup-cloudflare-15-menit)
- [Part 3: Setup GitHub Secrets](#part-3-setup-github-secrets-2-menit)
- [Part 4: Run RDP](#part-4-run-rdp-5-10-menit)
- [Part 5: Connect ke RDP](#part-5-connect-ke-rdp)
- [Part 6: Verifikasi](#part-6-verifikasi)
- [Part 7: Save Kerjaan](#part-7-save-kerjaan)
- [Tips Pro](#tips-pro)
- [FAQ](#faq)

---

## Part 1: Setup Akun & Repo (5 menit)

### 1.1. Fork Repository

1. Buka halaman repository `xy-rdp`
2. Klik tombol **Fork** (kanan atas)
3. Pilih akun GitHub kamu
4. Tunggu sampai fork selesai (~10 detik)

### 1.2. (Opsional) Rename Repo

1. Di repo yang sudah di-fork, klik **Settings**
2. Scroll ke **Repository name**
3. Ganti jadi misal: `my-cloud-rdp` atau `xydesk`
4. Klik **Rename**

## Part 2: Setup Cloudflare (15 menit)

### Kenapa Cloudflare?

- **GRATIS** untuk personal use
- Dapet **HTTPS** otomatis
- Bisa pake **domain sendiri** (lebih profesional)
- **Login Google** terintegrasi (aman, ga mencurigakan)

### 2.1. Daftar Cloudflare

1. Buka https://dash.cloudflare.com/sign-up
2. Sign up pakai **email yang sama** dengan Google kamu
3. Verifikasi email

### 2.2. Tambah Domain

**Opsi A: Punya domain sendiri**

1. Beli domain di Namecheap / Cloudflare Registrar / Porkbun
   - Rekomendasi murah: `.id` (~Rp 100rb/tahun), `.dev` (~$12/tahun)
2. Di Cloudflare dashboard, klik **+ Add a Site**
3. Masukkan domain kamu (misal: `xydev.id`)
4. Pilih plan **Free**
5. Cloudflare akan scan DNS records
6. **Ganti nameserver** di registrar kamu ke yang dikasih Cloudflare

**Opsi B: Belum punya domain**

- Beli di Cloudflare Registrar langsung (gampang, 1 tempat)
- Harga mulai $10/tahun untuk `.com`, lebih murah untuk TLD lain

### 2.3. Create Tunnel

1. Di dashboard, klik menu **Zero Trust** (kiri bawah)
2. **First-time setup**: pilih plan **Free** (cukup untuk personal)
3. Pilih **Networks** > **Tunnels**
4. Klik **Create a tunnel**
5. Pilih **Cloudflared** > klik **Next**
6. Isi:
   - **Tunnel name**: `xydesk-rdp`
   - (Opsional) **Location**: terserah
7. Klik **Save tunnel**
8. **COPY TOKEN** > simpan di notepad. Contoh:
   ```
   eyJhIjoiNzM5YWMxNzMtYmVmYS00NGY0LWEzZmItY2E4...
   ```

### 2.4. Configure Public Hostname

1. Di tunnel detail, klik tab **Public Hostname**
2. Klik **Add a public hostname**
3. Isi form:
   - **Subdomain**: `rdp` (nanti jadi `rdp.yourdomain.com`)
   - **Domain**: pilih domain kamu dari dropdown
   - **Service**:
     - Type: **RDP**
     - URL: `localhost:13389`
4. Klik **Save hostname**

### 2.5. Setup Google Login

1. **Buka Google Cloud Console**: https://console.cloud.google.com/
2. **Create project**:
   - Klik dropdown project (atas) > **New Project**
   - Name: `Xydesk RDP`
   - **Create**

3. **Setup OAuth consent screen**:
   - Menu **APIs & Services** > **OAuth consent screen**
   - User type: **External** > **Create**
   - App information:
     - App name: `Xydesk Cloud Desktop`
     - User support email: email kamu
   - App domain (opsional tapi bagus):
     - Application home page: `https://yourdomain.com`
     - Privacy policy: `https://yourdomain.com/privacy`
   - Developer contact: email kamu
   - **Save and Continue**
   - Scopes: **Add or remove scopes** > pilih:
     - `openid`
     - `.../auth/userinfo.email`
     - `.../auth/userinfo.profile`
   - **Save and Continue**
   - Test users: tambahkan email kamu
   - **Save and Continue**

4. **Create OAuth Client**:
   - Menu **Credentials** > **Create credentials** > **OAuth client ID**
   - Application type: **Web application**
   - Name: `Xydesk Cloudflare`
   - **Authorized JavaScript origins**:
     ```
     https://yourdomain.com
     ```
   - **Authorized redirect URIs** > **PENTING!**
     ```
     https://yourdomain.com/cdn-cgi/access/callback
     https://<your-team>.cloudflareaccess.com/cdn-cgi/access/callback
     ```
     > Ganti `<your-team>` dengan team name kamu (bisa dilihat di URL Cloudflare Zero Trust dashboard)
   - Klik **Create**
   - **COPY** Client ID dan Client Secret!

### 2.6. Connect Google ke Cloudflare

1. Balik ke **Cloudflare Zero Trust dashboard**
2. **Settings** > **Authentication**
3. Klik **Add new**
4. Isi:
   - **Name**: `Google`
   - **Type**: **Google**
   - **App ID**: paste Client ID dari Google
   - **App secret**: paste Client Secret
   - (Opsional) **Email addresses**: whitelist email tertentu
5. Klik **Save**

### 2.7. Protect Tunnel dengan Access

1. **Access** > **Applications** > **Add an application**
2. Type: **Self-hosted**
3. Klik **Next**
4. Isi:
   - **Application name**: `Xydesk RDP`
   - **Application domain**:
     - Select existing: `rdp.yourdomain.com`
   - (Opsional) **Logo**
   - **Identity providers**: `Google`
   - **Session duration**: `24 hours` (atau lebih pendek, misal `1 hour`)
5. Klik **Next**
6. **Policy**:
   - **Policy name**: `My Email Only`
   - **Action**: **Allow**
   - **Session duration**: `30 days`
   - **Include**:
     - Selector: **Emails**
     - Value: email kamu
7. Klik **Next** > **Add application**

## Part 3: Setup GitHub Secrets (2 menit)

1. Di repo GitHub kamu, klik **Settings**
2. **Secrets and variables** > **Actions**
3. Klik **New repository secret**

Tambahkan secrets berikut:

### CLOUDFLARE_TUNNEL_TOKEN

- Value: token tunnel dari Part 2.3
- Klik **Add secret**

### CLOUDFLARE_TUNNEL_ID

- Value: ID tunnel (bisa dilihat di Cloudflare > Tunnels > klik tunnel kamu > lihat URL/detail)
- Format: UUID atau string panjang
- Klik **Add secret**

### (Opsional) TAILSCALE_AUTH_KEY

- Daftar di https://tailscale.com/ (gratis)
- Generate key: https://login.tailscale.com/admin/settings/keys
- Pilih **Reusable**, **Ephemeral** OFF
- **Generate key** > copy
- Klik **Add secret**

## Part 4: Run RDP (5-10 menit)

1. Di repo GitHub, klik tab **Actions**
2. Pilih workflow **Xydesk Windows RDP** (kiri)
3. Klik **Run workflow** (kanan)
4. Isi input:
   - **Password**: misal `Xydesk2026MySecure!` (min 8 char, alphanumeric)
   - **Duration**: `6` jam
   - **RDP Port**: `13389` (atau custom)
   - **Install AI tools?**: centang Yes
   - **Install Docker?**: centang Yes
5. Klik **Run workflow** (hijau)
6. Tunggu ~5-10 menit

## Part 5: Connect ke RDP

### Cara 1: Browser (Recommended)

1. Buka **https://rdp.yourdomain.com** di Chrome/Edge
2. Muncul halaman login Cloudflare Access
3. Klik **Sign in with Google**
4. Pilih akun Google kamu (yang di-whitelist)
5. Browser otomatis launch RDP di tab baru
6. **Done!** Kamu udah di Windows Server

### Cara 2: Microsoft Remote Desktop (Mobile/Desktop)

**Install app:**

- **Windows**: https://aka.ms/rdclient (atau dari Microsoft Store)
- **Mac**: App Store > cari "Microsoft Remote Desktop"
- **Android**: Play Store > cari "RD Client"
- **iOS**: App Store > cari "RD Client"

**Setup connection:**

1. Buka app > **+ Add PC**
2. **PC name**: `rdp.yourdomain.com:13389`
3. **User account**:
   - Klik **+ Add**
   - Username: `Xydesk`
   - Password: yang kamu set di workflow
4. **Friendly name**: `Xydesk Cloud` (terserah)
5. **Save** > double-click untuk connect

### Cara 3: IP Langsung (Tanpa Domain)

1. Di GitHub Actions, klik run yang lagi jalan
2. Klik step **Get connection info**
3. Expand log, cari **Direct IP** (misal: `20.127.45.89`)
4. Connect ke `20.127.45.89:13389` dari RDP client
5. **Note**: IP ini berubah tiap run, jadi harus dicatat ulang

## Part 6: Verifikasi

Setelah login, cek apakah tools sudah terinstall:

1. Buka **Start Menu** > cari:
   - Visual Studio Code
   - Google Chrome
   - Git Bash
   - Docker Desktop
   - Ollama (kalau di-enable)
2. Buka **Command Prompt** atau **PowerShell**:
   ```bash
   node --version    # v24.x.x
   python --version  # Python 3.13.x
   go version        # go1.25.x
   rustc --version   # rustc 1.91.x
   java -version     # openjdk version "25"
   dotnet --version  # 9.0.x
   ```
3. Semua harusnya muncul tanpa error > **sukses!**

## Part 7: Save Kerjaan

**PENTING**: RDP session cuma 6 jam, kerjaan hilang setelah itu!

### Cara save:

1. **Git**: push code ke GitHub repo
   ```bash
   cd C:\Users\Xydesk\Documents\my-project
   git init
   git add .
   git commit -m "work from RDP"
   git push origin main
   ```

2. **Cloud storage**: OneDrive / Google Drive / Dropbox
   - Install OneDrive di RDP
   - Sync folder `C:\Users\Xydesk\Documents`

3. **Tailscale**: akses folder RDP dari PC lokal
   - RDP & PC lokal sama-sama join Tailscale network
   - Bisa `\\tailscale-ip\c$\Users\Xydesk\Documents`

## Tips Pro

1. **Bookmark** link `rdp.yourdomain.com` di browser
2. **Install** Bitwarden extension di Chrome RDP untuk simpan password
3. **Setup sync** VS Code Settings dengan GitHub account
4. **Gunakan Windows Terminal** (sudah pre-installed) untuk split panes
5. **Install WSL** kalau mau Linux dalam Windows:
   ```powershell
   wsl --install
   ```

## FAQ

**Q: Aman ga simpan data penting di RDP?**

A: GitHub runner ga persistent > semua data hilang setelah session. JANGAN simpan data sensitif (kredit card, password utama). Selalu sync ke cloud.

**Q: Bisa lebih dari 6 jam?**

A: Ga bisa. GitHub Actions max 6 jam per job. Tapi bisa re-run workflow (dengan minutes tambahan).

**Q: Bisa pake Android/iOS?**

A: Bisa! Install "RD Client" app, connect ke `rdp.yourdomain.com:13389`.

**Q: Berapa lama setup total?**

A: ~30 menit untuk first time (Cloudflare setup paling lama). Next time cuma 5 menit.

**Q: Bisa pake private repo?**

A: Bisa, tapi dapet 2000 menit/bulan (vs unlimited untuk public). Untuk personal use, public repo cukup.

**Q: Gratis beneran?**

A: 100% gratis:

- GitHub Actions: free tier
- Cloudflare Tunnel: free plan
- Domain: ~$10/tahun (opsional, bisa pake Cloudflare subdomain gratis juga)

---

Butuh bantuan? Open issue di repo atau baca [FAQ lengkap](../README.md#troubleshooting).
