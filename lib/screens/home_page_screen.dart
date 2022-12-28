import 'package:fire/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}
class _HomescreenState extends State<Homescreen> {



@override
void didChangeDependencies(){
  final authProvider = Provider.of<Authprovider>(context , listen: false);
  authProvider.updateEmailVarificationState();
  super.didChangeDependencies();
}



  @override
  Widget build(BuildContext context) {
    return Consumer<Authprovider>(builder: (context, model, _) {
      return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {model.logOut();},
              icon: const Icon(Icons.logout),
              color: Colors.redAccent,
            )
          ],
          title: const Text('Welcome'),
          backgroundColor: Colors.black38,
          centerTitle: true,
        ),
        body:  Center(
          child: model.emailVarified ?? false ?
          const Text('Email Varified'):
          const   Text('Email is not varified'),
        ),
      );
    });
  }
}
