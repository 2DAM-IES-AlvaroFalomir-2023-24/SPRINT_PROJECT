import 'package:flutter/material.dart';
import 'package:sprint/data/odoo_connect.dart';
import 'package:sprint/screens/login_screen.dart';
import 'package:sprint/screens/user_screen.dart';

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
        // Tema generado automáticamente utilizando el color corporativo de Odoo como
        // semilla para el esquema de color
        // TODO falta añadir un tono rojizo para los botones que tengan opciones peligrosas
        theme:ThemeData(
            useMaterial3: true,
            colorSchemeSeed: const Color(0xFF714B67)),
        darkTheme: ThemeData(
            brightness: Brightness.dark,
            useMaterial3: true,
            colorSchemeSeed: const Color(0xFF714B67)),
        home: SafeArea(
          child: UserScreen(),
        ));
  }
}
