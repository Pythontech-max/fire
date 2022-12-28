import 'package:fire/provider/auth_provider.dart';
import 'package:fire/screens/Authscreens.dart';
import 'package:fire/screens/home_page_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Widget/keys.dart';

void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create:  (_)=> Authprovider())],
      child: MaterialApp(
        scaffoldMessengerKey: Keys.scaffoldMessangerKey,
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(

            primarySwatch: Colors.blue,
          ),
          home:  StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges() ,
            builder: (context , snapshot){
              if(snapshot.hasData){
                return const Homescreen();
              }
              else {
                return const AuthScreen();
              }
            } ,
          )
      ),
    );
  }
}


