import 'package:chat_app/screens.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Welcome Page'),automaticallyImplyLeading: false,),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 100,),
              ElevatedButton(onPressed: (){
                Navigator.pushNamed(context, '/login');
               /* Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                        const LoginPage()));*/
              }, child: const Text('login Page'))
            ],
          ),
        ),
      ),
    );
  }
}
