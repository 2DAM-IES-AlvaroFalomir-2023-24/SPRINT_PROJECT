import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sprint/bloc/bloc_user/user_bloc.dart';
import 'package:sprint/bloc/bloc_user/user_event.dart';
import 'package:sprint/bloc/register_bloc.dart';
import 'package:sprint/data/odoo_connect.dart';
import 'package:sprint/screens/home_screen.dart';
import 'package:sprint/screens/register_screen.dart';
import 'package:sprint/app_localizations.dart';

import 'package:sprint/bloc/social_sign_and_login.dart';
import 'package:sprint/widget/custom_elevated_button_iconified_with_text.dart';
import 'package:sprint/widget/custom_elevated_button_with_text.dart';

import '../model/odoo-user.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>{

  late bool _passwordVisible;
  late TextEditingController passwordController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    passwordController = TextEditingController();
    emailController = TextEditingController();
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
                Padding(
                    padding:
                    const EdgeInsets.symmetric(vertical: 16.0),
                    child: CustomElevatedButtonIconifiedWithText(
                      onPressedFunction: () async {
                        final provider =
                        Provider.of<SingAndLoginClass>(context,
                            listen: false);

                        if (await provider.signInWithFacebook()) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                        }
                      },
                      text: 'Facebook',
                      icon: Image.asset("assets/facebook_logo.png", scale: 20),
                    )
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: CustomElevatedButtonIconifiedWithText(
                        onPressedFunction: () async {
                          final provider = Provider.of<SingAndLoginClass>(context,listen: false);
                          if (await provider.googleLogin()) {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomeScreen()),);
                          }
                        },
                        text: AppLocalizations.of(context)!
                            .translate('signInGoogle'),
                        icon: Image.asset("assets/google_logo.png", scale: 20)
                    )
                ),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: AppLocalizations.of(context)!.translate('emailHintText'),
                    labelText: AppLocalizations.of(context)!.translate('email')
                    )
                ),
                TextFormField(
                  controller: passwordController,
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
                          loginWithEmailAndPass(email: emailController.text.trim(), password: passwordController.text.trim(), context: context).then((value) async {
                            if(value){
                              OdooUser? temp = await OdooConnect.getUserByEmail(emailController.text.trim());
                              context.read<UserBloc>().add(UserInformationChangedEvent(temp!));
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                            }
                          });
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