# Contributing to Xydesk RDP

Terima kasih sudah mau kontribusi! Panduan singkat di bawah.

## Cara Kontribusi

1. **Fork** repository ini
2. **Buat branch** untuk fitur/fix kamu:
   ```bash
   git checkout -b feature/nama-fitur
   ```
3. **Commit** perubahan kamu:
   ```bash
   git commit -m "Add: deskripsi singkat"
   ```
4. **Push** ke branch kamu:
   ```bash
   git push origin feature/nama-fitur
   ```
5. **Buka Pull Request** di repo utama

## Guidelines

- **Test dulu** sebelum submit PR (jalankan workflow di fork kamu)
- **Update dokumentasi** kalau ada perubahan konfigurasi
- **Ikuti style** yang sudah ada (indentasi, naming, dll)
- **Satu PR = satu fitur/fix** (jangan campur)
- **Deskripsikan dengan jelas** apa yang diubah dan kenapa

## Area Kontribusi

Yang paling dibutuhkan:

- Tambah software/tools baru (lihat workflow untuk pattern)
- Update versi software ke yang lebih baru
- Improve security hardening
- Tambah dokumentasi (Troubleshooting, FAQ, dll)
- Fix bug atau typo
- Translate dokumentasi ke bahasa lain

## Testing

Sebelum submit PR, test di fork kamu:

1. Fork repo
2. Add secrets yang diperlukan (Cloudflare token, dll)
3. Run workflow dengan setting default
4. Pastikan semua step hijau (tidak ada error)
5. Test koneksi RDP

## Pertanyaan?

Buka **Discussion** di tab GitHub, atau kontak maintainer lewat issue.

---

Happy contributing!
