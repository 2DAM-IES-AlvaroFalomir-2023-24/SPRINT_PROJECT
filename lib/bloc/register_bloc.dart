import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

Future signUpWithEmailAndPassword({required String email, required String password}) async {
      Logger logger = Logger();
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      }on FirebaseAuthException catch(e){
        logger.e('FirebaseAuthException: ${e.message}');
      }catch(e){
        logger.e('Error: $e');
      }
}


