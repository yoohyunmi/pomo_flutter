import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _key = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFb64748),
      body: Center(
        child: Form(
          key: _key,
          child: Column(
            children: [
              const SizedBox(height: 80),
              const Text('✔︎ Pomofocus',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              const Text('Create Account',
                  style: TextStyle(
                      color: Color.fromARGB(255, 227, 204, 204),
                      fontSize: 18,
                      letterSpacing: 1.4,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 15),
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
                    emailInput(),
                    const Spacer(),
                    Text('PASSWORD',
                        style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 14,
                            fontWeight: FontWeight.w700)),
                    passwordInput(),
                    const Spacer(),
                    Text('PASSWORD (CONFIRM)',
                        style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 14,
                            fontWeight: FontWeight.w700)),
                    passwordConfirm(),
                    const Spacer(),
                    signupButton(),
                    const Spacer(),
                  ]),
                ),
              ),
              const SizedBox(height: 30),
              const Text('Already have an account ?',
                  style: TextStyle(
                    color: Color.fromRGBO(227, 204, 204, 1),
                    fontSize: 16,
                  )),
              const SizedBox(height: 5),
              const Text('Log in',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white))
            ],
          ),
        ),
      ),
    );
  }

  TextFormField emailInput() {
    return TextFormField(
      controller: _emailController,
      validator: (val) {
        if (val!.isEmpty) {
          return 'The input is empty.';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        hintText: 'example@mail.com',
        hintStyle: TextStyle(color: Colors.grey[400]),
        border: InputBorder.none,
      ),
    );
  }

  TextFormField passwordInput() {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      validator: (val) {
        if (val!.isEmpty) {
          return 'The input is empty.';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        border: InputBorder.none,
      ),
    );
  }

  TextFormField passwordConfirm() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        border: InputBorder.none,
      ),
    );
  }

  TextButton signupButton() {
    return TextButton(
      onPressed: () async {
        if (_key.currentState!.validate()) {
          try {
            final Credential = await FirebaseAuth.instance
                .createUserWithEmailAndPassword(
                    email: _emailController.text,
                    password: _passwordController.text)
                .then((_) => Navigator.pushNamed(context, '/'));
          } on FirebaseAuthException catch (e) {
            if (e.code == 'weak-password') {
              print('The password provided is too weak.');
            } else if (e.code == 'email-already-in-use') {
              print('The account already exists for that email.');
            }
          } catch (e) {
            print(e.toString());
          }
        }
      },
      style: TextButton.styleFrom(
        backgroundColor: Colors.grey[850],
        fixedSize: Size(330, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Text(
        'Sign Up',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
