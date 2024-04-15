import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({super.key});

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

final _user = FirebaseAuth.instance.currentUser;
String? _email = _user?.email;
String? _username =
    _user?.displayName == null ? 'Pomofocus User' : _user?.displayName;

class _MyAccountScreenState extends State<MyAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '✔︎ Pomofocus',
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5),
        ),
        backgroundColor: const Color(0xFFb64748),
        centerTitle: false,
      ),
      body: Column(children: [
        Padding(
            padding: EdgeInsets.all(5),
            child: Column(
              children: [
                Divider(
                  color: Color.fromARGB(255, 112, 43, 45),
                  thickness: 0.2,
                ),
                const SizedBox(height: 40),
                ListTile(
                  leading: Icon(Icons.face),
                  title: Text('My Account Info'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('User name : $_username'),
                      Text('Email : $_email')
                    ],
                  ),
                ),
                const Divider(
                  color: Color.fromARGB(255, 112, 43, 45),
                ),
                ListTile(
                  hoverColor: Color.fromARGB(255, 181, 81, 83),
                  leading: Icon(Icons.exit_to_app),
                  title: TextButton(
                    onPressed: _signOut,
                    child: Text(
                      'Logout',
                    ),
                    style: TextButton.styleFrom(
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                ),
                const Divider(
                  color: Color.fromARGB(255, 112, 43, 45),
                ),
                const ListTile(
                  leading: Icon(Icons.delete_forever),
                  title: Text('Delete Account'),
                )
              ],
            ))
      ]),
      backgroundColor: Color.fromARGB(255, 254, 116, 118),
    );
  }

  _signOut() async {
    await FirebaseAuth.instance.signOut().then((_) =>
        Navigator.push(context, MaterialPageRoute(builder: (_) => MyApp())));
  }
}
