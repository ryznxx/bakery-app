🍞 Bakery App | Aplikasi Penjualan Roti (VSGA Komdigi DTS)

Aplikasi mobile sederhana berbasis Android (target platform) yang berfungsi untuk mencatat transaksi penjualan roti, mencakup input data pembeli, pengambilan lokasi GPS, dan penyimpanan data lokal menggunakan database SQLite melalui library Sqflite di Flutter.

Proyek ini dibuat sebagai syarat kelulusan dan demonstrasi keahlian pada program sertifikasi VSGA Komdigi Digital Talent Scholarship (DTS).

🚀 Fitur Utama

Daftar Produk: Menampilkan daftar roti (dummy data) yang tersedia.

Pencatatan Pembelian: Halaman khusus untuk mencatat nama pembeli dan item yang dibeli.

Integrasi GPS: Mengambil dan menyimpan koordinat Latitude dan Longitude pembeli saat transaksi dilakukan, menggunakan library geolocator.

Penyimpanan Lokal: Menyimpan semua riwayat transaksi secara persisten di perangkat menggunakan Sqflite (SQLite database lokal).

Admin Dashboard: Halaman terpisah untuk menampilkan seluruh riwayat pembelian yang tersimpan dalam database lokal, diurutkan berdasarkan waktu terbaru.

🛠️ Teknologi yang Digunakan

Kategori

Teknologi/Library

Kegunaan

Framework

Flutter (Dart)

Pengembangan Aplikasi Multi-platform (Fokus Android)

Database

Sqflite

Driver untuk database SQLite lokal (Penyimpanan Persisten)

Peta/Lokasi

Geolocator

Mengakses dan meminta izin untuk data GPS (Latitude, Longitude)

Utility

path

Membantu mendapatkan dan mengelola path database lokal

Utility

intl

Formatting tanggal dan waktu untuk tampilan Admin Page

⚙️ Konfigurasi Penting (Wajib Android)

Pastikan file android/app/src/main/AndroidManifest.xml telah menyertakan izin lokasi untuk geolocator:

<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />


📂 Struktur Proyek

Struktur proyek diorganisasi untuk memenuhi praktik terbaik pemisahan kekhawatiran (separation of concerns):

lib/
├── database/           # Logic Database Manager (DbManager)
│   └── db_manager.dart
├── models/             # Definisi kelas data (BakeryItem, Purchase)
│   └── item_model.dart
├── pages/              # Halaman UI Aplikasi
│   ├── admin_page.dart # Menampilkan riwayat transaksi
│   ├── buy_page.dart   # Input pembelian dan GPS
│   └── home_page.dart  # Daftar item dan navigasi
└── main.dart           # Titik masuk aplikasi dan inisialisasi DB


👨‍💻 Panduan Instalasi dan Menjalankan Proyek

Prasyarat

Flutter SDK terinstal dan dikonfigurasi.

Android Studio / VS Code dengan plugin Flutter.

Emulator Android atau perangkat fisik dengan USB debugging diaktifkan.

Langkah-langkah

Clone Repositori:

git clone [URL_REPOSITORI_ANDA]
cd bakery_app


Dapatkan Dependensi:

flutter pub get


Jalankan Aplikasi:
Pastikan emulator atau perangkat Anda sudah terhubung (adb devices).

flutter run


Tips Debugging (Mengambil DB)

Jika Anda perlu memeriksa data yang tersimpan di SQLite secara langsung (misalnya saat ujian), gunakan perintah adb untuk menarik file database dari perangkat:

# Ganti bakery_app.db dengan nama file yang Anda inginkan
adb exec-out run-as com.example.bakery_app cat databases/bakery.db > bakery_app.db


Setelah ditarik, file bakery_app.db dapat dibuka menggunakan alat seperti DB Browser for SQLite.