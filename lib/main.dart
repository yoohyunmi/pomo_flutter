import 'package:flutter/material.dart';
import 'package:pomo_flutter/screen/main_screen.dart';

import 'screen/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
//      home: const HomeScreen(),
      routes: {
        '/': (context) => const HomeScreen(),
        '/login': (context) => const LoginScreen()
      },
      initialRoute: '/',
    );
  }
}
