import 'package:flutter/material.dart';
import 'package:tesapp/ui/home_screen.dart';
import 'package:tesapp/ui/login_screen.dart';
import 'package:tesapp/ui/tambah_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Employee App',
      home: LoginScreen(),
      routes: {
        'login': (context) => LoginScreen(),
        'home': (context) => HomeScreen(),
      },
    );
  }
}
