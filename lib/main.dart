import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'pages/login_page.dart';
import 'pages/main_page.dart';
import 'services/cart_service.dart';
import 'services/session_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter(); // inisialisasi Hive
  await Hive.openBox(CartService.boxName); // buka box untuk menyimpan library

  // Cek session: kalau email sudah tersimpan, langsung ke halaman utama
  final email = await SessionService.getEmail();
  runApp(MyApp(isLoggedIn: email != null));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopedia',
      debugShowCheckedModeBanner: false,
      // Tema gelap sesuai contoh tampilan di soal
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
      ),
      home: isLoggedIn ? const MainPage() : const LoginPage(),
    );
  }
}
