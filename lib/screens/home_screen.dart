import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sprint/screens/register_screen.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }else if(snapshot.hasError){
            return const Center(
              child: Text('Something went wrong'),
            );
          }else if(snapshot.hasData){
            return const Center(
              child: Text('Home Screen'),
            );
          }else{
            return const RegisterScreen();
          }
        }
      ),
    );
  }
  
}