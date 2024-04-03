import 'package:flutter/material.dart';

class NaviBottom extends StatefulWidget {
  const NaviBottom({super.key});

  @override
  State<NaviBottom> createState() => _NaviBottomState();
}

class _NaviBottomState extends State<NaviBottom> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFFb64748),
      unselectedItemColor: Color.fromARGB(255, 69, 32, 33),
      unselectedFontSize: 14,
      selectedItemColor: const Color(0xFFe3b6b6),
      selectedFontSize: 18,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined), label: 'Report'),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings_applications), label: 'Settings'),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_pin_sharp), label: 'Login'),
      ],
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/');
            setState(() {});
            break;
          case 1:
            Navigator.pushNamed(context, '/');
            break;
          case 2:
            Navigator.pushNamed(context, '/login');
            setState(() {});
            break;
        }
      },
    );
  }
}
