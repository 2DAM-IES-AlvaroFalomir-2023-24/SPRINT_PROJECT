import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sprint/data/odoo_connect.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class UserController {

  static User? user = FirebaseAuth.instance.currentUser;

  Future<User> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    User userCredential = (await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential)).user!;
    tryLoginOnOdoo(userCredential);

    return userCredential;
  }

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
    tryLoginOnOdoo(userCredential.user);
    return userCredential.user;
  }

  void tryLoginOnOdoo(User? userCredential) {
    String email = userCredential?.email ?? "";
    if(OdooConnect.getUserByEmail(email) != null){
      return true;
    }
  }
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }
}
