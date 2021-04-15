import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:brightness_manager/brightness_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  BrightnessManager brightnessManager;

  var _currentBrightness = 0.1;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    brightnessManager = BrightnessManager();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Brightness manager example'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Opacity(
                  opacity: _currentBrightness,
                  child: Icon(
                    Icons.brightness_high,
                    size: 64,
                    color: Colors.red,
                  ),
                ),
              ),
              Slider(
                value: _currentBrightness,
                onChanged: (value) {
                  setState(() {
                    _currentBrightness = value;
                    brightnessManager.setBrightness(value);
                    print("Current brightness = $_currentBrightness");
                  });
                },
                min: 0.1,
                max: 1.0,
                divisions: 10,
              )
            ],
          )),
    );
  }
}
