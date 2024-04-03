import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pomo_flutter/firebase_options.dart';
import 'package:pomo_flutter/screen/main_screen.dart';
import 'package:pomo_flutter/screen/signup_screen.dart';
import 'screen/login_screen.dart';

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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const HomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen()
      },
      initialRoute: '/',
    );
  }
}
