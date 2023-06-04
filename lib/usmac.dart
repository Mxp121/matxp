import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UCMAC',
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UCMAC'),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
          height: 50,
        ),
        Image.asset(
          "assets/1.jpeg",
          height: 200,
          width: 200,
        ),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(onPressed: () {}, child: Text("Generate")),
        Row(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Answer",
              ),
            ),
            SizedBox(
              width: 5,
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.check))
          ],
        ),
      ]),
    );
  }
}
