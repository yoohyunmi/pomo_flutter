import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pomo_flutter/screen/login_screen.dart';

import 'common/bottom_navigation.dart';
import 'package:dotted_border/dotted_border.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color? getColor(Set<MaterialState> states) => Colors.white;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext con, AsyncSnapshot<User?> user) {
          if (!user.hasData) {
            return const LoginScreen();
          } else {
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
              body: Column(
                children: [
                  const Divider(
                    color: Color.fromARGB(255, 112, 43, 45),
                    thickness: 0.2,
                  ),
                  const SizedBox(height: 40),
                  Container(
                    height: 320,
                    width: 500,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFFc15b5c),
                    ),
                    child: Column(
                      children: [
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Container(
                                    width: 120,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      color: const Color(0xFFa44d4f),
                                    ),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      "Pomodoro",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    )),
                              ),
                              const SizedBox(
                                height: 170,
                                child: Text(
                                  "25:00",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 110,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Libre Franklin',
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: onStart,
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  fixedSize: Size(180, 60),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: Text("START",
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Color(0xFFa44d4f),
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Column(
                    children: [
                      SizedBox(height: 20),
                      SizedBox(
                        child: Text(
                          "#1",
                          style: TextStyle(
                            color: Color(0xFFe3b6b6),
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Text(
                        "Time to focus!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 500,
                    child: Row(
                      children: [
                        const Text(
                          "Tasks",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const Expanded(
                          child: Text(""),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.more_vert,
                            color: Colors.white,
                            size: 22,
                          ),
                          label: const Text(''),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(193, 91, 92, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 500,
                    child: Divider(
                      color: Colors.white,
                      thickness: 1.2,
                    ),
                  ),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 500.0,
                          height: 70,
                          child: DottedBorder(
                            dashPattern: [3, 2.4],
                            color: Color(0xFFe3b6b6),
                            strokeWidth: 1,
                            borderType: BorderType.RRect,
                            borderPadding: EdgeInsets.all(1),
                            radius: const Radius.circular(10),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 163, 56, 58),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.playlist_add_rounded,
                                    color: Color(0xFFe3b6b6),
                                  ),
                                  Text(
                                    " Add Task",
                                    style: TextStyle(
                                      color: Color(0xFFe3b6b6),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ])),
                ],
              ),
              backgroundColor: const Color(0xFFb64748),
              bottomNavigationBar: const NaviBottom(),
            );
          }
        });
  }

  void onStart() {}
}
