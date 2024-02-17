import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sprint/bloc/google_sign_in.dart';
import 'package:sprint/routes/screens_routes.dart';
import 'package:sprint/widget/verify_auth_widget.dart';
import 'package:provider/provider.dart';
import 'package:sprint/data/odoo_connect.dart';
import 'package:sprint/bloc/bloc_user/user_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sprint/app_localizations.dart';

import 'package:sprint/firebase_options.dart';

Future main() async {
  await dotenv.load(fileName: "././assets/.env");
  OdooConnect.initialize();
  // Asegura que la vinculación de widgets esté inicializada.
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final Map<String, WidgetBuilder> rutasApp = {};
  for (final ruta in rutas) {
    rutasApp[ruta.nombre] = (context) => ruta.widget;
  }

  runApp(MyApp(rutasApp: rutasApp));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.rutasApp});

  final Map<String, WidgetBuilder> rutasApp;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
        create: (context) => UserBloc(),
        child: ChangeNotifierProvider(
          create: (context) => GoogleSignInProvider(),
          child: MaterialApp(
              routes: rutasApp,
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
                  child: VerifyAuthWidget())),
        ));
  }
}
