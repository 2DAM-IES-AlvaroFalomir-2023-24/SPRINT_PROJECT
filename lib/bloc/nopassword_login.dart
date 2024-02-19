import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:logger/logger.dart';

class NoPasswordLogin {
  Future<bool> singWithoutPass(String mail) async {
    try {
      var acs = ActionCodeSettings(
        // URL you want to redirect back to. The domain (www.example.com) for this
        // URL must be whitelisted in the Firebase Console.
          url: 'https://sprintproject.page.link/tobR?email=$mail',
          // This must be true
          handleCodeInApp: true,
          iOSBundleId: 'com.example.sprint',
          androidPackageName: 'com.example.sprint',
          // installIfNotAvailable
          androidInstallApp: true,
          // minimumVersion
          androidMinimumVersion: '12');

      FirebaseAuth.instance
          .sendSignInLinkToEmail(email: mail, actionCodeSettings: acs)
          .catchError(
              (onError) => print('Error sending email verification $onError'))
          .then((value) {
        return segundoPaso();
      });
      return true;
    } catch (e) {
      Logger().e(e);
      return false;
    }
  }

  Future<void> segundoPaso() async {
    final PendingDynamicLinkData? initialLink = await FirebaseDynamicLinks.instance.getInitialLink();
    if (initialLink != null) {
      if(FirebaseAuth.instance.isSignInWithEmailLink(initialLink.link.toString())){
        print("iniciado");
      }else{
        throw 'Could not launch link';
      }
      // Example of using the dynamic link to push the user to a different screen
    }else{
      throw 'Could not launch link';
    }

  }
}