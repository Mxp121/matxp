import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  final Function(int) onSpeedChanged;
  final int currentSpeed;

  SettingPage({
    Key? key,
    required this.onSpeedChanged,
    required this.currentSpeed,
  }) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  late int _speed;

  @override
  void initState() {
    super.initState();
    _speed = widget.currentSpeed;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Animation Speed',
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: Slider(
                    value: _speed.toDouble(),
                    min: 1.0,
                    max: 10.0,
                    divisions: 9,
                    onChanged: (value) {
                      setState(() {
                        _speed = value.toInt();
                      });
                    },
                  ),
                ),
                SizedBox(width: 16.0),
                Text(
                  '$_speed',
                  style: TextStyle(fontSize: 24.0),
                ),
              ],
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                widget.onSpeedChanged(_speed);
                Navigator.pop(context);
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
