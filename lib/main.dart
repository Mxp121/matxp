import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'About-1.dart';
import 'Setting-1.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      title: 'USMAC Number Quiz',
      home: NumberQuiz(),
    );
  }
}

class NumberQuiz extends StatefulWidget {
  @override
  _NumberQuizState createState() => _NumberQuizState();
}

class _NumberQuizState extends State<NumberQuiz>
    with SingleTickerProviderStateMixin {
  int num1 = Random().nextInt(10);
  int num2 = Random().nextInt(10);
  String operation = "select the opration";
  int correctAnswer = 0;
  TextEditingController answerController = TextEditingController();
  late AnimationController _controller;
  late Animation<double> _animation;
  int speed = 5;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: speed),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(_controller);
  }

  void checkAnswer() {
    int userAnswer = int.tryParse(answerController.text) ?? -1;
    int result = 0;
    switch (operation) {
      case '+':
        result = num1 + num2;
        break;
      case '-':
        result = num1 - num2;
        break;
      case '×':
        result = num1 * num2;
        break;
      case '÷':
        result = num1 % num2 == 0 ? num1 ~/ num2 : -1;
        while (result % 2 != 0) {
          num1 = Random().nextInt(10);
          num2 = Random().nextInt(10);
          result = num1 % num2 == 0 ? num1 ~/ num2 : -1;
        }
        break;
    }

    setState(() {
      correctAnswer = result;
    });
    if (userAnswer == result) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Correct!'),
            content: Text('$num1 $operation $num2 = $result'),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  _controller.reset();
                  _controller.forward();
                  setState(() {
                    num1 = Random().nextInt(10);
                    num2 = Random().nextInt(10);

                    correctAnswer = 0;
                    answerController.clear();
                  });
                  Navigator.of(context).pop();
                },
                child: Text('Next Question'),
              ),
            ],
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Incorrect! Please try again.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ucmas Number Quiz',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                child: Icon(Icons.settings),
                value: 'settings',
              ),
              PopupMenuItem(
                child: Icon(Icons.speed),
                value: 'speed',
              ),
              PopupMenuItem(
                child: Text("Oprations"),
                value: 'Oparations',
              ),
              PopupMenuItem(
                child: Icon(Icons.info),
                value: 'about',
              ),
            ],
            onSelected: (value) {
              if (value == 'settings') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingPage(
                      currentSpeed: speed,
                      onSpeedChanged: (newSpeed) {
                        setState(() {
                          speed = newSpeed;
                          _controller.duration = Duration(seconds: speed);
                        });
                      },
                    ),
                  ),
                );
              } else if (value == 'about') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutPage()),
                );
              } else if (value == 'Oparations') {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Select the Opration'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: Text('+'),
                            onTap: () {
                              setState(() {
                                operation = "+";
                              });
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            title: Text('-'),
                            onTap: () {
                              setState(() {
                                operation = "-";
                              });
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            title: Text('×'),
                            onTap: () {
                              setState(() {
                                operation = "×";
                              });
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            title: Text('÷'),
                            onTap: () {
                              setState(() {
                                operation = "÷";
                              });
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else if (value == 'speed') {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Select Animation Speed'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: Text('Slow'),
                            leading: Icon(Icons.arrow_drop_down),
                            onTap: () {
                              setState(() {
                                speed = 10;
                                _controller.duration = Duration(seconds: speed);
                              });
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            title: Text('Normal'),
                            leading: Icon(Icons.arrow_right),
                            onTap: () {
                              setState(() {
                                speed = 5;
                                _controller.duration = Duration(seconds: speed);
                              });
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            title: Text('Fast'),
                            leading: Icon(Icons.arrow_drop_up),
                            onTap: () {
                              setState(() {
                                speed = 2;
                                _controller.duration = Duration(seconds: speed);
                              });
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            },
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue, Colors.white],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FadeTransition(
                opacity: _animation,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Image.asset(
                      'assets/$num1.jpg',
                      width: 200.0,
                      height: 200.0,
                    ),
                    Text(
                      operation,
                      style: TextStyle(fontSize: 50),
                    ),
                    Image.asset(
                      'assets/$num2.jpg',
                      width: 200.0,
                      height: 200.0,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                width: 100.0,
                child: TextField(
                  controller: answerController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                  decoration: InputDecoration(
                    hintText: 'Enter answer',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  _controller.reset();
                  _controller.forward();
                  checkAnswer();
                },
                child: Text('Check Answer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
