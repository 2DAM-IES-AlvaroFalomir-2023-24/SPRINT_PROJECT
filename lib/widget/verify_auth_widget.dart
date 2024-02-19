import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprint/bloc/bloc_user/user_bloc.dart';
import 'package:sprint/bloc/bloc_user/user_event.dart';
import 'package:sprint/data/odoo_connect.dart';
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
            return const Center(child: Text('Error de autenticación'));
          } else if (snapshot.hasData) {
            OdooConnect.getUserByEmail(snapshot.data!.email!).then((value) =>
                context.read<UserBloc>().add(UserInformationChangedEvent(value!)));

            return const HomeScreen();
          } else {
            return const LoginScreen();
          }
        });
  }
}
