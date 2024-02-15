import 'package:flutter/material.dart';
import 'package:sprint/data/odoo_connect.dart';

import '../model/language.dart';
import '../model/user.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>{

  // late User a = User("a", "a", true, "a", Language.enUS);
  @override
  void initState() {
    super.initState();
    OdooConnect.initialize();
    // OdooConnect.getUserByEmail("damproyectoflutter@gmail.com").then((value) => a = value!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //body: Image.memory(base64Decode(a.avatar)),
    );
  }

}