import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'common/bottom_navigation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: InputBorder.none,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
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
                  Text('Forgot Password',
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
            const SizedBox(height: 5),
            RichText(
                text: TextSpan(
                    text: 'Create account',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Navigator.pushNamed(context, '/signup')))
          ],
        ),
      ),
      bottomNavigationBar: NaviBottom(),
    );
  }
}
