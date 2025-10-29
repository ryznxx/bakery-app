# 🍞 Bakery App | Aplikasi Penjualan Roti (VSGA Komdigi DTS)

Aplikasi mobile sederhana berbasis **Android (target platform)** yang berfungsi untuk mencatat transaksi penjualan roti.  
Meliputi input data pembeli, pengambilan lokasi GPS, serta penyimpanan data lokal menggunakan **SQLite (Sqflite)** di **Flutter**.

Proyek ini dibuat sebagai **syarat kelulusan dan demonstrasi keahlian** pada program sertifikasi **VSGA Komdigi Digital Talent Scholarship (DTS)**.

---

## 🚀 Fitur Utama

- **Daftar Produk**  
  Menampilkan daftar roti (dummy data) yang tersedia.

- **Pencatatan Pembelian**  
  Halaman khusus untuk mencatat nama pembeli dan item yang dibeli.

- **Integrasi GPS**  
  Mengambil dan menyimpan koordinat *Latitude* dan *Longitude* pembeli saat transaksi dilakukan (library: `geolocator`).

- **Penyimpanan Lokal**  
  Menyimpan seluruh riwayat transaksi di database lokal menggunakan `Sqflite`.

- **Admin Dashboard**  
  Halaman untuk menampilkan seluruh riwayat pembelian yang tersimpan di database lokal, diurutkan berdasarkan waktu terbaru.

---

## 🛠️ Teknologi yang Digunakan

| Kategori       | Teknologi / Library | Kegunaan |
|----------------|--------------------|-----------|
| **Framework**  | Flutter (Dart)     | Pengembangan aplikasi multiplatform (fokus Android) |
| **Database**   | Sqflite            | Driver untuk database SQLite lokal (penyimpanan persisten) |
| **Peta/Lokasi**| Geolocator         | Mengakses dan meminta izin lokasi GPS |
| **Utility**    | path               | Mengelola direktori dan path database lokal |
| **Utility**    | intl               | Format tanggal dan waktu untuk tampilan admin |

---

## ⚙️ Konfigurasi Penting (Wajib Android)

Pastikan file `android/app/src/main/AndroidManifest.xml` telah menyertakan izin lokasi berikut:

```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
````

---

## 📂 Struktur Proyek

```
lib/
├── database/           
│   └── db_manager.dart        # Logic Database Manager
├── models/             
│   └── item_model.dart        # Definisi kelas data (BakeryItem, Purchase)
├── pages/              
│   ├── admin_page.dart        # Menampilkan riwayat transaksi
│   ├── buy_page.dart          # Input pembelian dan GPS
│   └── home_page.dart         # Daftar item dan navigasi utama
└── main.dart                  # Titik masuk aplikasi dan inisialisasi DB
```

---

## 👨‍💻 Panduan Instalasi & Menjalankan Proyek

### Prasyarat

* Flutter SDK sudah terinstal & dikonfigurasi.
* Android Studio / VS Code dengan plugin Flutter.
* Emulator Android atau perangkat fisik dengan USB Debugging aktif.

### Langkah-langkah

1. **Clone repositori:**

   ```bash
   git clone [URL_REPOSITORI_ANDA]
   cd bakery_app
   ```

2. **Dapatkan dependensi:**

   ```bash
   flutter pub get
   ```

3. **Jalankan aplikasi:**
   Pastikan emulator atau perangkat Anda sudah terhubung:

   ```bash
   adb devices
   flutter run
   ```

---

## 🧠 Tips Debugging (Mengambil Database SQLite)

Jika ingin memeriksa isi database secara langsung:

```bash
# Ganti bakery_app.db dengan nama file yang diinginkan
adb exec-out run-as com.example.bakery_app cat databases/bakery.db > bakery_app.db
```

File `bakery_app.db` yang berhasil ditarik dapat dibuka menggunakan alat seperti
**DB Browser for SQLite** untuk melihat data transaksi.

---

## 📜 Lisensi

Proyek ini dibuat untuk keperluan pendidikan dan demonstrasi.
Silakan modifikasi, gunakan, dan kembangkan sesuai kebutuhan.
