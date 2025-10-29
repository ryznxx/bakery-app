import 'package:flutter/material.dart';

// Model untuk Item Roti
class BakeryItem {
  final int id;
  final String name;
  final String description;
  final double price;
  final IconData icon;

  BakeryItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.icon,
  });
}

// Model untuk Data Pembelian yang akan disimpan di Sqflite
class Purchase {
  final int? id;
  final String buyerName;
  final String itemName;
  final double latitude;
  final double longitude;
  final String purchaseDate;

  Purchase({
    this.id,
    required this.buyerName,
    required this.itemName,
    required this.latitude,
    required this.longitude,
    required this.purchaseDate,
  });

  // Konversi Purchase menjadi Map (untuk Sqflite)
  Map<String, dynamic> toMap() {
    return {
      'buyerName': buyerName,
      'itemName': itemName,
      'latitude': latitude,
      'longitude': longitude,
      'purchaseDate': purchaseDate,
    };
  }

  // Konversi Map menjadi objek Purchase
  factory Purchase.fromMap(Map<String, dynamic> map) {
    return Purchase(
      id: map['id'] as int?,
      buyerName: map['buyerName'] as String,
      itemName: map['itemName'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      purchaseDate: map['purchaseDate'] as String,
    );
  }
}

// Dummy Data untuk Roti
final List<BakeryItem> dummyBakeryItems = [
  BakeryItem(
    id: 1,
    name: "Croissant Cokelat",
    description: "Croissant renyah dengan isian cokelat lumer.",
    price: 15000,
    icon: Icons.bakery_dining,
  ),
  BakeryItem(
    id: 2,
    name: "Roti Keju Garlic",
    description: "Roti lembut dengan bumbu bawang putih dan keju mozarella.",
    price: 22000,
    icon: Icons.microwave,
  ),
  BakeryItem(
    id: 3,
    name: "Donat Gula Halus",
    description: "Donat klasik yang ditaburi gula halus.",
    price: 8000,
    icon: Icons.donut_large,
  ),
  BakeryItem(
    id: 4,
    name: "Kue Tart Merah",
    description: "Kue tart red velvet ukuran mini.",
    price: 45000,
    icon: Icons.cake,
  ),
];
