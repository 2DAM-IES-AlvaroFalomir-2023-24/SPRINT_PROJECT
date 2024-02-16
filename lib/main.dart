import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sprint/screens/verify_auth_screen.dart';
import 'package:sprint/data/odoo_connect.dart';
import 'package:sprint/bloc/bloc_user/user_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprint/screens/login_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sprint/app_localizations.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future main() async {
  await dotenv.load(fileName: "./assets/.env");
  OdooConnect.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Para que el patrón bloc funcione debemos arrancar el BlocProvider desde el main,
  // luego en el body del Scaffold de cada pantalla debemos instanciar el BlocBuilder
  // para poder llamar los métodos declarados en user_event

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
        create: (context) => UserBloc(),
        child: MaterialApp(
            title: 'Sprint Project',
            debugShowCheckedModeBanner: false,
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('es', 'ES'),
            ],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            localeResolutionCallback: (locale, supportedLocales) {
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale?.languageCode &&
                    supportedLocale.countryCode == locale?.countryCode) {
                  return supportedLocale;
                }
              }
              return supportedLocales.first;
            },
            theme: ThemeData(
                useMaterial3: true, colorSchemeSeed: const Color(0xFF714B67)),
            darkTheme: ThemeData(
                useMaterial3: true,
                brightness: Brightness.dark,
                colorSchemeSeed: const Color(0xFF714B67)),
            home: const SafeArea(
                //Comentar la clase VerifyAuthBloc del archivo verify_auth.dart
                // para hacer las pruebas en local
                // y escribe la clase de tu pantalla
                child: VerifyAuthBloc()
            
            )));
  }
}
