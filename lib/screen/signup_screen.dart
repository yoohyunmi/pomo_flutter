import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pomo_flutter/screen/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _key = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFb64748),
      body: Center(
        child: Form(
          key: _key,
          child: Column(
            children: [
              const SizedBox(height: 40),
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
                    emailInput(),
                    const Spacer(),
                    passwordInput(),
                    const Spacer(),
                    passwordConfirm(),
                    const Spacer(),
                    TextButton(
                      onPressed: _signup,
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
                    ),
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
              TextButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen())),
                  child: Text('Log in'),
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
      ),
    );
  }

  TextFormField emailInput() {
    return TextFormField(
      controller: _emailController,
      validator: _validateEmail,
      onChanged: _validateEmail,
      decoration: InputDecoration(
        labelText: 'EMAIL',
        labelStyle: TextStyle(
            color: Colors.grey[400], fontSize: 14, fontWeight: FontWeight.w700),
        floatingLabelAlignment: FloatingLabelAlignment.start,
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
        labelText: 'PASSWORD',
        labelStyle: TextStyle(
            color: Colors.grey[400], fontSize: 14, fontWeight: FontWeight.w700),
        floatingLabelAlignment: FloatingLabelAlignment.start,
        filled: true,
        fillColor: Colors.grey[200],
        border: InputBorder.none,
      ),
    );
  }

  TextFormField passwordConfirm() {
    return TextFormField(
      obscureText: true,
      validator: (val) {
        if (val!.isEmpty) {
          return 'The input is empty.';
        }
        if (val != _passwordController.text) {
          return 'Password don\'t match!';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        labelText: 'PASSWORD (CONFIRM)',
        labelStyle: TextStyle(
            color: Colors.grey[400], fontSize: 14, fontWeight: FontWeight.w700),
        floatingLabelAlignment: FloatingLabelAlignment.start,
        filled: true,
        fillColor: Colors.grey[200],
        border: InputBorder.none,
      ),
    );
  }

  _signup() async {
    if (_key.currentState!.validate()) {
      print('Goood!!');
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
//            .then((_) => Navigator.pushNamed(context, '/'));
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        print(e.code);
        String message = '';
        if (e.code == 'weak-password') {
          message = 'The password provided is too weak.';
        } else if (e.code == 'email-already-in-use') {
          message = 'The account already exists for that email.';
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            message,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red[900],
        ));
      } catch (e) {
        print(e.toString());
      }
    }
  }

  String? _validateEmail(String? val) {
    if (val!.isEmpty) {
      return 'Email is required.';
    } else if (!isEmailValid(val)) {
      return 'Enter a valid email address.';
    } else {
      return null;
    }
  }
}

bool isEmailValid(String email) {
  return RegExp(r'^[\w-\.]+@[a-zA-Z]+\.[a-zA-Z]{2,}$').hasMatch(email);
}
