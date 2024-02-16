import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:sprint/data/odoo_connect.dart';
import 'package:sprint/screens/login_screen.dart';

import 'bloc/google_sign_in.dart';

Future main() async{
  await dotenv.load(fileName: "./assets/.env");
  OdooConnect.initialize();

  // Asegura que la vinculación de widgets esté inicializada.
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa Firebase para la aplicación.
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
          title: 'Sprint Project',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          home: const SafeArea(
            child: LoginScreen(),
          )
      ),
    );
  }
}