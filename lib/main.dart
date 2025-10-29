import 'package:flutter/material.dart';
import 'package:bakery_app/pages/home/home_page.dart';
import 'package:bakery_app/database/helper/helpert.dart';

void main() async {
  // Pastikan Flutter Widgets siap
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi database sebelum aplikasi berjalan
  await DbHelper().database;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bakery App - Android Only',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
      ),
      home: const HomePage(),
    );
  }
}
