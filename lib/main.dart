import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sprint/data/odoo_connect.dart';
import 'package:sprint/screens/login_screen.dart';

Future main() async {
  await dotenv.load(fileName: "assets/.env");
  OdooConnect.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Sprint Project',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF714B67))),
        darkTheme: ThemeData(
            brightness: Brightness.dark,
            colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF714B67))),
        home: const SafeArea(
          child: LoginScreen(),
        ));
  }
}
