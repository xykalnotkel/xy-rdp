# Cloudflare API Token Baru - Dibutuhkan Sekarang

Token Cloudflare yang ada (`cfut_...`) **hanya untuk verifikasi**, ga punya scope untuk bikin tunnel. Saya butuh kamu bikin token baru.

## Langkah (2 menit)

1. Buka: **https://dash.cloudflare.com/profile/api-tokens**
2. Klik **Create Token**
3. Pilih **Create Custom Token** (paling bawah)
4. Isi:
   - **Token name**: `Xydesk RDP Setup`
   - **Permissions** (klik Add):
     ```
     Account > Cloudflare Tunnel: Edit
     Account > Account Settings: Read
     Zone > DNS: Edit (pilih zone: xyc.my.id)
     Zone > Zone: Read
     ```
   - **Account Resources**: Include > Specific account > pilih akun kamu
   - **Zone Resources**: Include > Specific zone > `xyc.my.id`
5. Klik **Continue to summary** > **Create Token**
6. **COPY TOKEN** (dimulai dari `...` - bukan `cfut_` lagi, biasanya panjang)

## Format

Token baru biasanya panjang, contoh:
```
AbCdEf1234567890...xyz=
```

## Kasih ke Saya

Begitu dapet, kasih tau saya. Format balasan: "token: [paste token di sini]"

Atau kalau mau otomatis (gw bikin via script), bisa juga — tapi perlu API key + email Cloudflare akun kamu (yang lebih sensitif lagi).

## Apa yang Akan Saya Lakukan Setelah Dapet Token

1. Bikin tunnel `xydesk-rdp` di `xyc.my.id`
2. Setup DNS record `rdp.xyc.my.id`
3. Push token sebagai GitHub Secret: `CLOUDFLARE_TUNNEL_TOKEN`
4. Kasih instruksi tinggal jalanin workflow

---

**Note**: token ini bakal di-push ke GitHub Secrets (aman, encrypted), bukan ke file di repo. Jadi aman.
