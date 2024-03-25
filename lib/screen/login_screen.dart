import 'package:flutter/material.dart';

import 'common/bottom_navigation.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Login')),
      bottomNavigationBar: NaviBottom(),
    );
  }
}
