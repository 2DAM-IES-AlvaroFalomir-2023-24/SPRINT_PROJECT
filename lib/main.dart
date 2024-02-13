import 'package:flutter/material.dart';
import 'package:sprint/data/odoo_connect.dart';
import 'package:sprint/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sprint Project',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: SafeArea(
        child: LoginScreen(),
      )
    );
  }
}