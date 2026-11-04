# MelodyLog – Music Diary Application

MelodyLog adalah aplikasi mobile berbasis Flutter yang digunakan untuk mencatat pengalaman mendengarkan musik. Pengguna dapat mencari lagu, menyimpan catatan pengalaman mendengarkan, memberikan rating, memilih mood, serta mengelola riwayat diary musik.

## Fitur Aplikasi

1. **Home Dashboard** – Menampilkan halaman utama aplikasi.
2. **Explore Music** – Mencari lagu menggunakan iTunes Search API.
3. **Song Detail** – Menampilkan informasi detail lagu.
4. **Add Diary** – Menambahkan catatan pengalaman mendengarkan musik.
5. **My Diary** – Menampilkan daftar catatan musik yang tersimpan.
6. **Edit Diary** – Mengubah catatan musik yang sudah dibuat.
7. **Delete Diary** – Menghapus catatan musik dengan konfirmasi.
8. **Profile** – Menampilkan informasi aplikasi.

## Teknologi yang Digunakan

- Flutter dan Dart
- Provider dan ChangeNotifier
- HTTP untuk komunikasi REST API
- iTunes Search API sebagai sumber data lagu
- Supabase sebagai backend dan database
- Git dan GitHub untuk version control

## Arsitektur Aplikasi

Aplikasi menggunakan pemisahan tanggung jawab berdasarkan beberapa lapisan:

- **Screens** – Menampilkan antarmuka aplikasi.
- **Widgets** – Menyediakan komponen UI yang dapat digunakan kembali.
- **Providers** – Mengelola state aplikasi menggunakan Provider dan ChangeNotifier.
- **Repositories** – Menjadi penghubung antara Provider dan Service.
- **Services** – Menangani komunikasi dengan API dan Supabase.
- **Models** – Mendefinisikan struktur data aplikasi.

## Database

Aplikasi menggunakan Supabase dengan tabel `music_diary_entries`.

Tabel tersebut menyimpan informasi:

- `id`
- `track_id`
- `track_name`
- `artist_name`
- `album_name`
- `artwork_url`
- `listened_at`
- `mood`
- `rating`
- `note`
- `created_at`

## Konfigurasi dan Menjalankan Aplikasi

### 1. Persiapan

Pastikan Flutter dan Dart sudah terpasang.

### 2. Instalasi Dependencies

Jalankan perintah:

```bash
flutter pub get
```

### 3. Konfigurasi Supabase

Buat file `supabase_config.json` di folder utama project dengan format:

```json
{
  "SUPABASE_URL": "URL_PROJECT_SUPABASE",
  "SUPABASE_PUBLISHABLE_KEY": "PUBLISHABLE_KEY_SUPABASE"
}
```

Ganti nilai tersebut dengan konfigurasi project Supabase milik sendiri.

**Catatan:** File konfigurasi yang berisi kredensial tidak boleh diunggah ke repository publik. Jangan pernah memasukkan `service_role` key ke dalam aplikasi Flutter.

### 4. Menjalankan Aplikasi

Jalankan:

```bash
flutter run --dart-define-from-file=supabase_config.json
```

## Pengujian

Pemeriksaan kode:

```bash
flutter analyze
```

Menjalankan pengujian:

```bash
flutter test
```

## Pengembang

Nama: Gede Rio Virgiawan Saputra

NIM: 2415051015

Program Studi: Pendidikan Teknik Informatika

Universitas Pendidikan Ganesha

## Repository

GitHub: https://github.com/riovirgiawan/melody_log
