import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'about_page.dart';
import 'setting_page.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'USMAC Number Quiz',
      home: NumberQuiz(),
    ));

class NumberQuiz extends StatefulWidget {
  @override
  _NumberQuizState createState() => _NumberQuizState();
}

class _NumberQuizState extends State<NumberQuiz>
    with SingleTickerProviderStateMixin {
  int num1 = Random().nextInt(10);
  int num2 = Random().nextInt(10);
  String operation = "Operation";
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
                child: Icon(Icons.settings, color: Colors.lightBlue,),
                value: 'Settings',
                textStyle: TextStyle(color: Colors.black),
              ),
              PopupMenuItem(
                child: Icon(Icons.speed, color: Colors.lightBlue,),
                value: 'Speed',
                textStyle: TextStyle(color: Colors.black),
              ),
              PopupMenuItem(
                child: Icon(Icons.add, color: Colors.lightBlue,),
                value: 'Oparations',
                textStyle: TextStyle(color: Colors.black),
              ),
              PopupMenuItem(
                child: Icon(Icons.info, color: Colors.lightBlue,),
                value: 'About',
                textStyle: TextStyle(color: Colors.black),
              ),
            ],
            onSelected: (value) {
              if (value == 'Settings') {
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
              } else if (value == 'About') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutPage()),
                );
              } else if (value == 'Operations') {
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
              } else if (value == 'Speed') {
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
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FadeTransition(
                  opacity: _animation,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/$num1.jpg',
                        width: 200.0,
                        height: 200.0,
                      ),
                      SizedBox(width: 5,),
                      Text(
                        operation,
                        style: TextStyle(fontSize: 50),
                      ),
                      SizedBox(width: 5,),
                      Image.asset(
                        'assets/$num2.jpg',
                        width: 200.0,
                        height: 200.0,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                TextField(
                  controller: answerController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                  decoration: InputDecoration(
                    hintText: 'Enter Your Answer',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
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
                  child: Text('Check the Answer'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
