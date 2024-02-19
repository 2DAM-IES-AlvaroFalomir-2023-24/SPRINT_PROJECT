import 'package:flutter/material.dart';
import 'package:sprint/screens/home_screen.dart';
import 'package:sprint/screens/register_screen.dart';
import 'package:sprint/app_localizations.dart';

import '../widget/custom_elevated_button_with_text.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>{

  late bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Image.asset("assets/odoo_logo.png", fit: BoxFit.cover, scale: 3),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: AppLocalizations.of(context)!.translate('usernameHintText'),
                    labelText: AppLocalizations.of(context)!.translate('username')
                    )
                ),
                TextFormField(
                  decoration: InputDecoration(
                    icon: const Icon(Icons.password),
                      hintText: AppLocalizations.of(context)!.translate('passwordHintText'),
                      labelText: AppLocalizations.of(context)!.translate("password"),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible ?
                          Icons.visibility :
                          Icons.visibility_off,
                          color: Theme.of(context).primaryColorLight,
                        ),
                        onPressed: (){
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      )
                  ),
                  obscureText: !_passwordVisible,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:24.0),
                  child: SizedBox(
                    height: 50,
                    width: 150,
                    child: CustomElevatedButtonWithText(
                        text: AppLocalizations.of(context)!.translate('login'),
                        onPressedFunction: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                        }
                    )
                  )
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(AppLocalizations.of(context)!.translate('dontHaveAccount')),
                    InkWell(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen())),
                        child: Text(
                            AppLocalizations.of(context)!.translate('register'),
                            style: const TextStyle(decoration: TextDecoration.underline)
                        )
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}