import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color? getColor(Set<MaterialState> states) => Colors.white;
  int _seconds = 60, _minutes = 25;
  bool _isRunning = false;
  String _showSeconds = "00", _showMinutes = "25";
  late Timer _timer;
  String _text = "START";
  late List<bool> isSelected;
  bool isWorking = true, isShortBreak = false, isLongBreak = false;

  AudioPlayer sound = AudioPlayer();

  // Add Task 부분
  bool _isAddingTask = false;
  final TextEditingController _taskInputController = TextEditingController();
  int _taskIndex = 0;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _startTimer() {
    _isRunning = true;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        _seconds = 60;
      }
      setState(() {
        // 25:00 ~ 시작 => 24:60
        // 00초 후에는 minutes--
        // 24:00 --> 23:59
        // minutes, seconds은 무조건 두자리로 보여줌
        _text = "PAUSE";

        if (_seconds == 60) {
          _minutes--;
        }
        _seconds--;

        if (_seconds.toString().length == 1) {
          _showSeconds = "0" + _seconds.toString();
        } else {
          _showSeconds = _seconds.toString();
        }

        if (_minutes.toString().length == 1) {
          _showMinutes = "0" + _minutes.toString();
        } else {
          _showMinutes = _minutes.toString();
        }
      });
    });
  }

  void _pauseTimer() {
    setState(() {
      _isRunning = false;
      _text = "START";
    });
    _timer.cancel();
  }

  @override
  void initState() {
    isSelected = [isWorking, isShortBreak, isLongBreak];
    super.initState();
  }

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
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ToggleButtons(
                              renderBorder: false,
                              children: [
                                Container(
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
                                Container(
                                    width: 120,
                                    height: 30,
                                    alignment: Alignment.center,
                                    child: const Text(
                                      "Short Break",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                      textAlign: TextAlign.center,
                                    )),
                                Container(
                                    width: 120,
                                    height: 30,
                                    alignment: Alignment.center,
                                    child: const Text(
                                      "Long Break",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                      textAlign: TextAlign.center,
                                    ))
                              ],
                              isSelected: isSelected,
                              onPressed: toggleSelect,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 170,
                        child: Text(
                          '$_showMinutes : $_showSeconds',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 110,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Libre Franklin',
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          sound.play(AssetSource('mouse-click-153941.mp3'));
                          _isRunning ? _pauseTimer() : _startTimer();
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          fixedSize: const Size(180, 60),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: Text('$_text',
                            style: const TextStyle(
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
              child: SizedBox(
            width: 500,
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(child: child, opacity: animation);
              },
              child: _isAddingTask ? _taskInputCard() : _addTaskButton(),
            ),
          )),
        ],
      ),
      backgroundColor: const Color(0xFFb64748),
    );
  }

  void toggleSelect(int index) {
    if (index == 0) {
      isWorking = true;
      isShortBreak = false;
      isLongBreak = false;
    } else if (index == 1) {
      isWorking = false;
      isShortBreak = true;
      isLongBreak = false;
    } else {
      isWorking = false;
      isShortBreak = false;
      isLongBreak = true;
    }

    setState(() {
      isSelected = [isWorking, isShortBreak, isLongBreak];
    });
  }

  void toggleAddTask() {
    setState(() {
      _isAddingTask = !_isAddingTask;
    });
  }

  Widget _addTaskButton() {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
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
          child: GestureDetector(
            onTap: () {
              print('click!! ${_isAddingTask}');
              toggleAddTask();
            },
            child: MouseRegion(
              // 마우스 hover 시 pointer 모양
              cursor: SystemMouseCursors.click,
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
        ),
      ),
    ]);
  }

  Widget _taskInputCard() {
    return Card(
      key: ValueKey('TaskInputCard'),
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'What are you working on?',
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 20,
                ),
                border: InputBorder.none,
              ),
              controller: _taskInputController,
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: toggleAddTask,
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                        color: Colors.grey[600], fontWeight: FontWeight.w600),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    _saveTask();
                    toggleAddTask();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Text('Save',
                      style: const TextStyle(
                        color: Colors.white,
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _saveTask() async {
    if (_taskInputController.text.isNotEmpty) {
      await _firestore.collection("tasks").add({
        "name": _taskInputController.text,
        "priority": 1,
        "timestamp": FieldValue.serverTimestamp(),
        "project": "",
      });
    }
  }
}
