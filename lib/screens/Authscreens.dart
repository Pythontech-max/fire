import 'package:fire/screens/email_pass_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Widget/Authbuttons.dart';
import 'PhoneAuthScreen.dart';
import 'google_signin_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Enter Details ',
                style: (TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ),
              SizedBox(
                height: 10,
              ),
              AuthBotton(
                iconData: Icons.email,
                title: ' Email',
                ontap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=> const EmailPassScreen() ));
                } ,
              ),
              AuthBotton(
                iconData: Icons.phone_android_rounded,
                title: ' Mobile',
                ontap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=> const PhoneAuthScreen() ));
                } ,
              ),
              AuthBotton(
                iconData: FontAwesomeIcons.google,
                title: ' Google',
                ontap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=> const googleSignInScreen() ));
                } ,
              ),


            ],
          ),
        ),
      ),
    );
  }
}
