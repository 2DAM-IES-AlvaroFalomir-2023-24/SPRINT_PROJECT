import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserController {

  static User? user = FirebaseAuth.instance.currentUser;

  Future<User?> signInWithGoogle() async {
    // Trigger the authentication flow
    final googleAccount = await GoogleSignIn().signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleAccount?.authentication;
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    // Once signed in
    final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    return userCredential.user;
  }
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }
}
