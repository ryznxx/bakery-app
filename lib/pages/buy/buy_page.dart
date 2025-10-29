import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:bakery_app/database/models/models.dart';
import 'package:bakery_app/database/helper/helpert.dart';

class BuyPage extends StatefulWidget {
  final BakeryItem item;
  const BuyPage({super.key, required this.item});

  @override
  State<BuyPage> createState() => _BuyPageState();
}

class _BuyPageState extends State<BuyPage> {
  final TextEditingController _nameController = TextEditingController();
  Position? _currentPosition;
  bool _isLoadingLocation = false;

  // Cek apakah tombol "Beli Sekarang" sudah aktif (nama terisi DAN lokasi sudah diambil)
  bool get isReadyToBuy =>
      _nameController.text.isNotEmpty && _currentPosition != null;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  // Fungsi untuk mendapatkan izin dan lokasi pengguna
  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoadingLocation = true;
    });

    try {
      // 1. Cek Service
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Layanan lokasi dinonaktifkan.');
      }

      // 2. Cek Izin
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Izin lokasi ditolak.');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception(
          'Izin lokasi ditolak permanen, harap buka pengaturan aplikasi.',
        );
      }

      // 3. Ambil Posisi
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentPosition = position;
        _isLoadingLocation = false;
      });
      _showSnackbar('Lokasi berhasil didapatkan!');
    } catch (e) {
      setState(() {
        _isLoadingLocation = false;
        _currentPosition = null; // Reset jika gagal
      });
      _showSnackbar(
        'Gagal mendapatkan lokasi: ${e.toString().split(':')[1].trim()}',
      );
    }
  }

  // Fungsi untuk menyimpan pembelian
  Future<void> _savePurchase() async {
    if (!isReadyToBuy) return;

    final newPurchase = Purchase(
      buyerName: _nameController.text,
      itemName: widget.item.name,
      latitude: _currentPosition!.latitude,
      longitude: _currentPosition!.longitude,
      purchaseDate: DateTime.now().toIso8601String(),
    );

    await DbHelper().insertPurchase(newPurchase);

    // Tampilkan notifikasi dan kembali ke Home
    if (mounted) {
      _showSnackbar('Pembelian ${widget.item.name} berhasil disimpan!');
      // Kembali ke halaman sebelumnya (Home Page)
      Navigator.pop(context);
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    // Memantau perubahan teks di controller untuk mengaktifkan/menonaktifkan tombol
    _nameController.addListener(() => setState(() {}));

    return Scaffold(
      appBar: AppBar(
        title: Text('Beli ${widget.item.name}'),
        backgroundColor: Colors.orange.shade100,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Detail Item
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(
                      widget.item.icon,
                      size: 48,
                      color: Colors.brown.shade700,
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.item.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.item.description,
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                          Text(
                            'Rp ${widget.item.price.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Input Nama
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nama Pembeli',
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Tombol Ambil Lokasi
            ElevatedButton.icon(
              onPressed: _isLoadingLocation ? null : _getCurrentLocation,
              icon: _isLoadingLocation
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.location_on),
              label: Text(
                _isLoadingLocation
                    ? 'Mengambil Lokasi...'
                    : 'Ambil Lokasi Sekarang',
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade600,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Tampilan Lokasi
            Text(
              'Koordinat Lokasi:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.brown.shade800,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _currentPosition != null
                    ? Colors.green.shade50
                    : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: _currentPosition != null
                      ? Colors.green.shade300
                      : Colors.grey.shade300,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Latitude: ${_currentPosition?.latitude.toStringAsFixed(6) ?? 'Belum diambil'}',
                  ),
                  Text(
                    'Longitude: ${_currentPosition?.longitude.toStringAsFixed(6) ?? 'Belum diambil'}',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // Tombol Beli Sekarang (Aktif Warna Hijau jika isReadyToBuy true)
            ElevatedButton(
              onPressed: isReadyToBuy ? _savePurchase : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: isReadyToBuy
                    ? Colors.green.shade600
                    : Colors.grey.shade400,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: isReadyToBuy ? 5 : 0,
              ),
              child: const Text(
                'Beli Sekarang',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
