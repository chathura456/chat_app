import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ConductorHome extends StatelessWidget {
  const ConductorHome({Key? key}) : super(key: key);

  Future<void>signOut()async{
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Conductor Home Page'),automaticallyImplyLeading: false,),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: (){
                signOut();
                /* Navigator.of(context, rootNavigator: true).pushReplacement(
                    MaterialPageRoute(builder: (context) => const LoginPage()));*/
              }, child: const Text('Logout'))
            ],
          ),
        ),
      ),
    );
  }
}
