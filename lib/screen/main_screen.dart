import 'package:flutter/material.dart';

import 'common/bottom_navigation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pomofocus',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5)),
        backgroundColor: const Color(0xFFb64748),
      ),
      body: Center(
        child: Expanded(
          child: Column(
            children: [
              const SizedBox(height: 40),
              Container(
                height: 300,
                width: 500,
                color: const Color(0xFFc15b5c),
                child: const Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Text("pomodoro"),
                      ),
                      SizedBox(
                        height: 100,
                        child: Text("25:00"),
                      ),
                      Text("START"),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 250,
                width: 500,
              ),
              const SizedBox(
                width: 500,
              )
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFFb64748),
      bottomNavigationBar: const NaviBottom(),
    );
  }
}
