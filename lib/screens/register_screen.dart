import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sprint/screens/home_screen.dart';

import '../bloc/google_sign_in.dart';

class RegisterScreen extends StatelessWidget{
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Register',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
                minimumSize: const Size(10, 60),
              ),
              child: const Icon(Icons.g_mobiledata,
                color: Colors.red,
                size: 50,
              ),
              onPressed: (){
                final provider = Provider.of<GoogleSignInProvider>(context, listen: false);

                provider.googleLogin();

                Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
              }
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder()
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder()
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Confirm Password',
                border: OutlineInputBorder()
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: (){},
              child: const Text('Register'),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Already have an account?'),
                TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: const Text('Login')
                )
              ],
            )
          ],
        ),
      )
    );
  }
  
}