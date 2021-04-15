import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:brightness_manager/brightness_manager.dart';

void main() {
  const MethodChannel channel = MethodChannel('brightness_manager');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

}
