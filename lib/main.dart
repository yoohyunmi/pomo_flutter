import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pomo_flutter/firebase_options.dart';

import 'screen/main_screen.dart';
import 'screen/login_screen.dart';
import 'screen/settings_screen.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  int _index = 0;
  final List<Widget> _tabBody = <Widget>[
    const HomeScreen(),
    const SettingScreen(),
    const LoginScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: _tabBody[_index],
      backgroundColor: const Color(0xFFb64748),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFb64748),
        unselectedItemColor: Color.fromARGB(255, 69, 32, 33),
        unselectedFontSize: 14,
        selectedItemColor: const Color(0xFFe3b6b6),
        selectedFontSize: 18,
        currentIndex: _index,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_outlined), label: 'Report'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_applications), label: 'Settings'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_pin_sharp), label: 'Login'),
        ],
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
      ),
    ));
  }
}
