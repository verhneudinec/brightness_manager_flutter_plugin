
import 'dart:async';

import 'package:flutter/services.dart';

const getBrightessMethod = "get_brightness";
const setBrightessMethod = "set_brightness";

class BrightnessManager {

  BrightnessManager({this.brightnessListener}){
    _initBrightnessManager();
  }

  static const MethodChannel _channel =
      const MethodChannel('brightness_manager');


  final Function(double brightness) brightnessListener;


  Future setBrightness(double brightness){
    return _channel.invokeMethod(setBrightessMethod, brightness);
  }

  void _initBrightnessManager(){
      _channel.setMockMethodCallHandler((call) async {
       switch(call.method){
         case getBrightessMethod:
           brightnessListener(call.arguments);
           break;
       }
      },
    );
  }
}
