import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'About',
      theme: ThemeData.dark(),
      home: AboutAPP(),
    );
  }
}

class AboutAPP extends StatefulWidget {
  @override
  _AboutAPPState createState() => _AboutAPPState();
}

class _AboutAPPState extends State<AboutAPP> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Page'),
      ),
      body: Container(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Text("Created By MXP  \"Matin Atef\"  ",style: TextStyle(
                    color: Colors.blue,
                    fontSize: 40,

                  ),)
                ]),
          )),
    );
  }
}
