import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sprint/screens/login_screen.dart';
import 'package:sprint/utils/sprint_exceptions.dart';
import 'package:sprint/widget/custom_elevated_button_with_text.dart';

class VerifyEmailDialog extends StatefulWidget {
  const VerifyEmailDialog({super.key});

  @override
  _VerifyEmailDialogState createState() => _VerifyEmailDialogState();
}

class _VerifyEmailDialogState extends State<VerifyEmailDialog> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
          const Duration(seconds: 3), (_) => checkEmailVerified());
    }
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  Future checkEmailVerified() async {
    // call after email verification!
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) timer?.cancel();
  }

  Future<void> sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() => canResendEmail = false);
      await Future.delayed(const Duration(seconds: 10));
      setState(() => canResendEmail = true);
    } catch (e) {
      throw EmailNotSentException(context);
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const LoginScreen()
      : AlertDialog(
        title: const Text('Verify Email'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                'An email has been sent to your email address.', //TODO: translate
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              CustomElevatedButtonWithText(
                text: 'Resend Email', //TODO: translate
                onPressedFunction: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                  canResendEmail ? sendVerificationEmail() : null;
                  Future.delayed(const Duration(seconds: 1), () {
                    Navigator.pop(context);
                  });
                },
              ),
              const SizedBox(height: 8),
              CustomElevatedButtonWithText(
                text: 'Cancel', // TODO: translate
                onPressedFunction: () => FirebaseAuth.instance.signOut().then(
                      (value) => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      ),
                    ),
              ),
            ],
          ),
        ),
      );
}
