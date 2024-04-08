import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _key = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFb64748),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Text('✔︎ Pomofocus',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            const Text('Login',
                style: TextStyle(
                    color: Color.fromARGB(255, 227, 204, 204),
                    fontSize: 18,
                    letterSpacing: 1.4,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 30),
            Container(
              width: 350,
              height: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(children: [
                  const Spacer(),
                  Text('EMAIL',
                      style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 14,
                          fontWeight: FontWeight.w700)),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      hintText: 'example@mail.com',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      border: InputBorder.none,
                    ),
                  ),
                  const Spacer(),
                  Text('PASSWORD',
                      style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 14,
                          fontWeight: FontWeight.w700)),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: InputBorder.none,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: _login,
                    child: Text(
                      'Log in with Email',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey[850],
                      fixedSize: Size(330, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Text('Forgot Password',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.grey)),
                  const Spacer(),
                ]),
              ),
            ),
            const SizedBox(height: 30),
            const Text('Do not have an account ?',
                style: TextStyle(
                  color: Color.fromRGBO(227, 204, 204, 1),
                  fontSize: 16,
                )),
            TextButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignupScreen())),
                child: Text('Create account'),
                style: TextButton.styleFrom(
                    primary: Colors.white,
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white)))
          ],
        ),
      ),
    );
  }

  _login() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text)
          .then((_) => Navigator.push(
              context, MaterialPageRoute(builder: (_) => MyApp())));
    } on FirebaseAuthException catch (e) {
      print(e.code);
      String message = '';

      if (e.code == 'user-not-found') {
        message = 'User not exists!';
      } else if (e.code == 'wrong-password') {
        message = 'Password is wrong!';
      } else if (e.code == 'invalid-email') {
        message = 'Please enter a valid email!';
      } else {
        message = e.code;
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.red[900],
      ));
    }
  }
}
