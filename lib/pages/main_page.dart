import 'package:flutter/material.dart';

import '../services/session_service.dart';
import 'home_page.dart';
import 'profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _index = 0;
  String? _email;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final email = await SessionService.getEmail();
    if (!mounted) return;
    setState(() => _email = email);
  }

  @override
  Widget build(BuildContext context) {
    if (_email == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final pages = [HomePage(email: _email!), ProfilePage(email: _email!)];
    return Scaffold(
      body: IndexedStack(index: _index, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
