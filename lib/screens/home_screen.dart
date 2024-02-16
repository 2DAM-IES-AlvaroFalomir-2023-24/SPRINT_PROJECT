import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sprint/screens/register_screen.dart';

import '../bloc/google_sign_in.dart';

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
            return Container(
              padding: const EdgeInsets.all(100),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('Cerrar Sesion'),
                  onPressed: (){
                    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);

                    provider.logout();

                    Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen()));
                  }
              ),
            );
          }else{
            return const RegisterScreen();
          }
        }
      ),
    );
  }
  
}