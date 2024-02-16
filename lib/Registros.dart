import 'dart:async';
import 'dart:convert' show json;

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sprint/data/odoo_connect.dart';
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
  GoogleSignInAccount? _currentUser;
  bool _isAuthorized = false; // has granted permissions?
  String _contactText = '';

  @override
  initState() {
    super.initState();
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    _currentUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await _currentUser
        ?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
// #enddocregion SignIn

// Prompts the user to authorize `scopes`.
//
// This action is **required** in platforms that don't perform Authentication
// and Authorization at the same time (like the web).
//
// On the web, this must be called from an user interaction (button click).
// #docregion RequestScopes
Widget _buildBody() {
  final GoogleSignInAccount? user = _currentUser;
  if (user != null) {
    // The user is Authenticated
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        ListTile(
          leading: GoogleUserCircleAvatar(
            identity: user,
          ),
          title: Text(user.displayName ?? ''),
          subtitle: Text(user.email),
        ),
        const Text('Signed in successfully.'),
        if (_isAuthorized) ...<Widget>[
          // The user has Authorized all required scopes
          Text(_contactText),
          ElevatedButton(
            onPressed: () {  },
            child: const Text('REFRESH'),
            //onPressed: () => _handleGetContact(user),
          ),
        ],
        if (!_isAuthorized) ...<Widget>[
          // The user has NOT Authorized all required scopes.
          // (Mobile users may never see this button!)
          const Text('Additional permissions needed to read your contacts.'),
          ElevatedButton(
           // onPressed: _handleAuthorizeScopes,
            onPressed: () {  },
            child: const Text('REQUEST PERMISSIONS'),
          ),
        ],
        ElevatedButton(
          //onPressed: _handleSignOut,
          onPressed: () {  },
          child: const Text('SIGN OUT'),
        ),
      ],
    );
  } else {
    // The user is NOT Authenticated
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        const Text('You are not currently signed in.'),
        // This method is used to separate mobile from web code with conditional exports.
        // See: src/sign_in_button.dart
        buildSignInButton(
          onPressed: signInWithGoogle,
        ),
      ],
    );
  }
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
      ));
}}
