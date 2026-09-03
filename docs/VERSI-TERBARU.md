# Versi Software (Updated: 2026-09-04)

Daftar versi terbaru yang di-install di RDP Xydesk.

## Daftar Isi

- [OS](#os)
- [Bahasa Pemrograman & Runtime](#bahasa-pemrograman--runtime)
- [Build Tools](#build-tools)
- [Editor & IDE](#editor--ide)
- [Browsers & Apps](#browsers--apps)
- [DevOps](#devops)
- [AI Tools (Opsional)](#ai-tools-opsional)
- [Package Managers](#package-managers)
- [Update Policy](#update-policy)

## OS

- **Windows Server**: 2022 (LTSC, latest dari GitHub runner)

## Bahasa Pemrograman & Runtime

| Software | Versi | Catatan |
|----------|-------|---------|
| Node.js | **24.11.0 LTS** | Aktif sampai April 2027 |
| Python | **3.13.7** | Stable, fast performance |
| Go | **1.25.1** | Latest stable |
| Rust | **1.91.0** | Stable channel |
| Java | **25 LTS** | OpenJDK Temurin, LTS sampai 2030+ |
| .NET | **9.0.108** | STS (Standard Term Support) |
| PHP | **8.4.12** | Latest stable |
| Ruby | **3.4.5** | Latest stable |

## Build Tools

| Software | Versi |
|----------|-------|
| CMake | **4.1.2** |
| Ninja | **1.13.1** |
| MSBuild | **17.x** (Visual Studio Build Tools 2022) |
| GCC/MinGW | via VS Build Tools |
| Clang | via VS Build Tools |

## Editor & IDE

| Software | Versi | Extensions |
|----------|-------|------------|
| VS Code | **1.96.0** (Oct 2024 > update terus ke latest) | Python, ESLint, Prettier, C++, Rust, Go, Java, .NET, Continue AI, Cline |

## Browsers & Apps

| Software | Versi |
|----------|-------|
| Google Chrome | Latest stable |
| Postman | Latest |
| 7-Zip | 25.01 |

## DevOps

| Software | Versi |
|----------|-------|
| Git | **2.51.0** |
| GitHub CLI | **2.83.0** |
| Docker Desktop | Latest |
| Tailscale | Latest stable |
| cloudflared | Latest |

## AI Tools (Opsional)

| Software | Versi | Models Pre-pulled |
|----------|-------|-------------------|
| Ollama | **0.11.10** | llama3.2:3b, qwen2.5-coder:7b |

## Package Managers

| Software | Versi |
|----------|-------|
| npm | Latest (bundled with Node 24) |
| pnpm | Latest (via corepack) |
| yarn | Latest (via corepack) |
| pip | Latest (bundled with Python 3.13) |
| cargo | Latest (bundled with Rust 1.91) |
| go modules | Built-in |

## Update Policy

Workflow ini **selalu pakai versi terbaru** saat run:

- Node.js LTS: otomatis detect versi LTS terbaru
- Python: ambil latest stable
- Java: LTS version
- Tools lain: latest stable

Untuk force update, edit file `.github/workflows/windows-rdp.yml` dan ubah env variables di section `env:`.
