import 'package:flutter/material.dart';
import 'package:sprint/screens/home_screen.dart';
import 'package:sprint/screens/login_screen.dart';
import 'package:sprint/screens/register_screen.dart';
import 'package:sprint/screens/user_screen.dart';

class Ruta {
  final String nombre;
  final Widget widget;
  final Map<String, String> parametros;

  Ruta({
    required this.nombre,
    required this.widget,
    this.parametros = const {},
  });
}

final List<Ruta> rutas = [
  Ruta(nombre: 'home', widget: const HomeScreen()),
  Ruta(nombre: 'register', widget: RegisterScreen()),
  Ruta(nombre: 'login', widget: const LoginScreen()),
  Ruta(nombre: 'user', widget: const UserScreen())
  // ...
];
