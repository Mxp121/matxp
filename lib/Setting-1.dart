import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MXP',
      theme: ThemeData.dark(),
      home: SettingAPP(),
    );
  }
}

class SettingAPP extends StatefulWidget {
  @override
  _SettingAPPState createState() => _SettingAPPState();
}

class _SettingAPPState extends State<SettingAPP> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MXp'),
      ),
      body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

              ])),
    );
  }
}
