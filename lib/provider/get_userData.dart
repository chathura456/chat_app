import 'package:chat_app/provider/user_service.dart';
import 'package:flutter/material.dart';
import '../Model/user_model.dart';
import 'user_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
/*
class UserDataConsumer extends StatelessWidget {
  final Widget child;
  //final Function(BuildContext, UserModel) onUserData;
 final User? user=FirebaseAuth.instance.currentUser;

  UserDataConsumer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, _) {
        return FutureBuilder(
          future: UserService().getUserData(user!.uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              userProvider.setUser(snapshot.data!);
              return child; // or any other widgets you want to show
            } else {
              return const CircularProgressIndicator();
            }
          },
        );
      },
    );
  }
}
*/

class UserDataConsumer extends StatelessWidget {
  final Widget child;
  final Function(BuildContext, UserModel) onUserData;

  const UserDataConsumer({super.key, required this.child, required this.onUserData});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        if (onUserData != null) {
          onUserData(context, userProvider.user);
        }
        return this.child;
      },
    );
  }
}
