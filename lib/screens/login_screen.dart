import 'package:flutter/material.dart';
import 'package:sprint/data/odoo_connect.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>{

  @override
  void initState() {
    super.initState();
    OdooConnect.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

}