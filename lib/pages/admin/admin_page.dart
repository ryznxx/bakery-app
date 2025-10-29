import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Perlu ditambahkan di pubspec.yaml jika belum ada, untuk format tanggal
import 'package:bakery_app/database/models/models.dart';
import 'package:bakery_app/database/helper/helpert.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard - Riwayat Pembelian'),
        backgroundColor: Colors.blue.shade100,
      ),
      body: FutureBuilder<List<Purchase>>(
        // Ambil data dari database
        future: DbHelper().getHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Terjadi Kesalahan: ${snapshot.error}'));
          }

          final purchases = snapshot.data ?? [];

          if (purchases.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inbox, size: 80, color: Colors.grey),
                  SizedBox(height: 10),
                  Text(
                    'Belum ada riwayat pembelian.',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          // Tampilkan riwayat dalam bentuk ListView
          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: purchases.length,
            itemBuilder: (context, index) {
              final purchase = purchases[index];
              final date = DateTime.tryParse(purchase.purchaseDate);
              // Tambahkan intl: ^0.18.1 di pubspec.yaml jika belum ada
              final formattedDate = date != null
                  ? DateFormat('dd MMM yyyy, HH:mm').format(date)
                  : 'Tanggal Tidak Diketahui';

              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: const Icon(
                    Icons.shopping_bag,
                    color: Colors.brown,
                    size: 30,
                  ),
                  title: Text(
                    purchase.buyerName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Item: ${purchase.itemName}'),
                      Text(
                        'Waktu: $formattedDate',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Lokasi: Lat ${purchase.latitude.toStringAsFixed(6)}, Lng ${purchase.longitude.toStringAsFixed(6)}',
                        style: const TextStyle(
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                  isThreeLine: true,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
