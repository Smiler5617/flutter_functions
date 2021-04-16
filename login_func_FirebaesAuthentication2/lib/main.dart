
import 'package:flutter/material.dart';
import 'login_parts/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Auth',
      home: Login(),
      routes: <String, WidgetBuilder>{
        '/login': (_) => new Login(),
      },
    );
  }
}

