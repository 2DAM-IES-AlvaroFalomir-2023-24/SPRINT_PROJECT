import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sprint/app_localizations.dart';
import 'package:sprint/screens/home_screen.dart';
import 'package:sprint/screens/login_screen.dart';

class VerifyAuthWidget extends StatelessWidget {
  const VerifyAuthWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return  Center(child: Text(AppLocalizations.of(context)!.translate('authError')));
          } else if (snapshot.hasData) {
            return HomeScreen();
          } else {
            return const LoginScreen();
          }
        });
  }
}
