import 'dart:async';
import 'dart:convert' show json;

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Controller/user_controller.dart';
import 'firebase_options.dart';
import 'src/sign_in_button.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "./assets/.env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    const MaterialApp(
      title: 'Google Sign In',
      home: SignInDemo(),
    ),
  );
}

/// The SignInDemo app.
class SignInDemo extends StatefulWidget {
  ///
  const SignInDemo({super.key});

  @override
  State createState() => _SignInDemoState();
}

class _SignInDemoState extends State<SignInDemo> {
  Widget _buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        const Text('You are not currently signed in.'),
        // This method is used to separate mobile from web code with conditional exports.
        // See: src/sign_in_button.dart
        buildSignInButton(
          onPressed: () async {
            try {
              final user = UserController().signInWithGoogle();
              if (user != null && mounted) {
                setState(() {
                  //Trabajar con user
                  print("User: ${user}");
                });
              }
            } on FirebaseAuthException catch (e) {
              print("Error: ${e}");
            }
          },
        ),
        FilledButton(
          onPressed: () async {
            try {
              final user = UserController().signOut();
              if (user != null && mounted) {
                setState(() {
                  //Trabajar con user
                });
              }
            } on FirebaseAuthException catch (e) {
              print("Error: ${e}");
            }
          }, child: Text('SIGN OUT'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Google Sign In'),
        ),
        body: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: _buildBody(),
        )
    );
  }
}
