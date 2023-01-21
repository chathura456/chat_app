import 'package:flutter/material.dart';
import 'package:chat_app/screens.dart';
import 'package:provider/provider.dart';
import '../provider/user_provider.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        return Scaffold(
          appBar: AppBar(title: const Text('Second Page'),),
          // other widgets
          body: Center(
            child: Column(children: [
              Text('Hello, ${userProvider.user.passenger?.points}')
            ],),
          ),
        );
      },
    );
  }
}

