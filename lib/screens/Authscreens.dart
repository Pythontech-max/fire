import 'package:fire/screens/email_pass_screen.dart';
import 'package:flutter/material.dart';

import '../Widget/Authbuttons.dart';

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
                title: 'Email/Password',
                ontap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=> const EmailPassScreen() ));
                } ,
              )
            ],
          ),
        ),
      ),
    );
  }
}
