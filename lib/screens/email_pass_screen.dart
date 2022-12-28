import 'package:fire/provider/auth_provider.dart';
import 'package:fire/screens/home_page_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Widget/custom_text_feild.dart';

class EmailPassScreen extends StatelessWidget {
  const EmailPassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Authprovider>(builder: (context, model, _) {
      return StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomTextfeild(
                          controller: model.emailController,
                          iconData: Icons.email,
                          hinttext: 'Email',
                        ),
                        CustomTextfeild(
                          controller: model.passwordController,
                          iconData: Icons.password,
                          hinttext: 'Password',
                        ),
                        if (model.authtype == AuthType.signUp)
                          CustomTextfeild(
                            controller: model.usernameController,
                            iconData: Icons.person,
                            hinttext: 'Username',
                          ),
                        TextButton(
                            onPressed: () {
                              model.authenticate();
                            },
                            child: model.authtype == AuthType.signUp
                                ? const Text('Sign UP')
                                : const Text('Sign In ')),
                        TextButton(
                            onPressed: () {
                              model.setAuthtype();
                            },
                            child: model.authtype == AuthType.signUp
                                ? const Text('Already Have an Account ?')
                                : const Text('Create an Account')),
                     if (model.authtype == AuthType.signIn)
                        TextButton(
                            onPressed: () {
                              model.resetPassword(context);
                            },
                            child:

                                 const Text('Reset Password')),


                      ],
                    ),
                  ),
                ),
              );
            } else {
              return
              const Homescreen();
            }
          });
    });
  }
}
