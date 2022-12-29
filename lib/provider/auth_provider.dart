import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire/Widget/custom_text_feild.dart';
import 'package:fire/Widget/keys.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authprovider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  AuthType _authtype = AuthType.signIn;

  AuthType get authtype => _authtype;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  setAuthtype() {
    _authtype =
        _authtype == AuthType.signIn ? AuthType.signUp : AuthType.signIn;
    notifyListeners();
  }

  authenticate() async {
    UserCredential userCredential;
    try {
      if (_authtype == AuthType.signUp) {
        userCredential = await firebaseAuth.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        await userCredential.user!.sendEmailVerification();
        firebaseFirestore
            .collection('Users')
            .doc(userCredential.user!.uid)
            .set({
          'email': userCredential.user!.email,
          'uid': userCredential.user!.uid,
          'user_name': usernameController.text,
        });
      }
      if (_authtype == AuthType.signIn) {
        userCredential = await firebaseAuth.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
      }
    } on FirebaseAuthException catch (error) {
      Keys.scaffoldMessangerKey.currentState!.showSnackBar(SnackBar(
        content: Text(error.code),
        backgroundColor: Colors.redAccent,
      ));
    } catch (error) {
      Keys.scaffoldMessangerKey.currentState!.showSnackBar(SnackBar(
        content: Text(error.toString()),
        backgroundColor: Colors.redAccent,
      ));
    }
  }

  bool? emailVarified;
  updateEmailVarificationState() async {
    emailVarified = firebaseAuth.currentUser!.emailVerified;

    if (!emailVarified!) {
      Timer.periodic(const Duration(seconds: 3), (timer) async {
        print('timer called');
        await firebaseAuth.currentUser!.reload();
        final user = FirebaseAuth.instance.currentUser;
        if (user!.emailVerified) {
          emailVarified = user!.emailVerified;
          timer.cancel();
          notifyListeners();
        }
      });
    }
  }

  TextEditingController resetEmailController = TextEditingController();
  resetPassword(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
              title: const Text('Enter your email '),
              content: CustomTextfeild(
                  iconData: Icons.email_outlined,
                  hinttext: 'Enter Email',
                  controller: resetEmailController),
              actions: [
                TextButton(
                    onPressed: () async {
                      final nevigator = Navigator.of(context).pop();
                      try {
                        await firebaseAuth.sendPasswordResetEmail(
                            email: resetEmailController.text);
                        Keys.scaffoldMessangerKey.currentState!
                            .showSnackBar(const SnackBar(
                          content: Text('Email send Successfully'),
                          backgroundColor: Colors.green,
                        ));
                        nevigator;
                      } catch (e) {
                        Keys.scaffoldMessangerKey.currentState!
                            .showSnackBar(SnackBar(
                          content: Text(e.toString()),
                          backgroundColor: Colors.redAccent,
                        ));
                        nevigator;
                      }
                    },
                    child: const Text('Submit'))
              ]);
        });
  }

  TextEditingController phoneController =
      TextEditingController(text: '+919260938663');
  verifyPhoneNumber(BuildContext context) async {
    try {
      await firebaseAuth.verifyPhoneNumber(
          phoneNumber: phoneController.text,
          timeout: const Duration(seconds: 30),
          verificationCompleted: (AuthCredential authCredential) {
            Keys.scaffoldMessangerKey.currentState!.showSnackBar(const SnackBar(
              content: Text('Varification Compleated'),
              backgroundColor: Colors.green,
            ));
          },
          verificationFailed: (FirebaseAuthException exception) {
            Keys.scaffoldMessangerKey.currentState!.showSnackBar(const SnackBar(
              content: Text('Varification Failed'),
              backgroundColor: Colors.redAccent,
            ));
          },
          codeSent: (
            String? verId,
            int? forceCodeResent,
          ) {
            Keys.scaffoldMessangerKey.currentState!.showSnackBar(const SnackBar(
              content: Text('Code Sent SuccessFully'),
              backgroundColor: Colors.green,
            ));
            varificationId = verId;
            otpDialogBox(context);
          },
          codeAutoRetrievalTimeout: (String verId) {
            Keys.scaffoldMessangerKey.currentState!.showSnackBar(const SnackBar(
              content: Text('Time Out '),
              backgroundColor: Colors.redAccent,
            ));
          });
    } on FirebaseAuthException catch (e) {
      Keys.scaffoldMessangerKey.currentState!.showSnackBar(SnackBar(
        content: Text(e.message!),
        backgroundColor: Colors.redAccent,
      ));
    }
  }

  String? varificationId;
  TextEditingController otpController = TextEditingController();
  otpDialogBox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text('Please enter your OTP'),
            content: CustomTextfeild(
              controller: otpController,
              iconData: Icons.password,
              hinttext: 'Enter OTP',
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    signInWithPhone();
                  },
                  child: const Text('Submit'))
            ],
          );
        });
  }

  signInWithPhone() async {
    await firebaseAuth.signInWithCredential(PhoneAuthProvider.credential(
        verificationId: varificationId!, smsCode: otpController.text));
  }

  GoogleSignIn googleSignIn = GoogleSignIn();

  signInwithGoogle() async {
  GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

  if(googleSignInAccount != null ){
    try{

    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    AuthCredential authCredential = GoogleAuthProvider.credential(
      accessToken:googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,


    );
      await firebaseAuth.signInWithCredential(authCredential);
      print(googleSignInAccount.photoUrl);
      print(googleSignInAccount.displayName);
      print(googleSignInAccount.email);
  } on FirebaseAuthException catch (e) {

      Keys.scaffoldMessangerKey.currentState!.showSnackBar(  SnackBar(
        content: Text(e.message!),
        backgroundColor: Colors.redAccent,
      ));

    }

  }


  else{

    Keys.scaffoldMessangerKey.currentState!.showSnackBar( const SnackBar(
      content: Text("Account Not Sellected"),
      backgroundColor: Colors.redAccent,
    ));
  }



  }



  logOut() async {
    try {
      await firebaseAuth.signOut();
      await googleSignIn.signOut();
    } catch (error) {
      Keys.scaffoldMessangerKey.currentState!.showSnackBar(SnackBar(
        content: Text(error.toString()),
        backgroundColor: Colors.redAccent,
      ));
    }
  }
}

enum AuthType {
  signUp,
  signIn,
}
