import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../services/cart_service.dart';
import '../services/session_service.dart';
import 'login_page.dart';

class ProfilePage extends StatelessWidget {
  final String email;

  const ProfilePage({super.key, required this.email});

  Future<void> _logout(BuildContext context) async {
    await SessionService.logout();
    if (!context.mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 24),
            const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 56)),
            const SizedBox(height: 24),
            Text(email, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ValueListenableBuilder(
              valueListenable: CartService.box.listenable(),
              builder: (context, box, child) {
                return Text('Produk dalam keranjang: ${CartService.count}');
              },
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                onPressed: () => _logout(context),
                child: const Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
