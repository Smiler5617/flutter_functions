import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login_parts/login.dart';
import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      return MaterialApp(
        title: 'Firebase Auth',
        home: Home(),
        routes: <String, WidgetBuilder>{
          '/login': (_) => Login(),
          '/roomselect': (_) => Home(),
        },
      );
    } else {
      return MaterialApp(
        title: 'Firebase Auth',
        home: Login(),
        routes: <String, WidgetBuilder>{
          '/login': (_) => Login(),
          '/roomselect': (_) => Home(),
        },
      );
    }
  }
}
