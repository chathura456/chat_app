import 'package:chat_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/screens.dart';
import 'package:chat_app/screens/auth_setup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app/provider/get_userData.dart';

class UserService {
  //...
  Future<UserModel> getUserData(String uid) async {
    var userRef = FirebaseFirestore.instance.collection("Users").doc(uid);
    var userSnapshot = await userRef.get();
    var data = userSnapshot.data();
    var passengerSnapshot = userRef.collection('Passenger').doc(uid);
    var passengerRef = await passengerSnapshot.get();
    var passengerData = passengerRef.data();

    UserModel loginUser = UserModel();
    loginUser= UserModel.fromMap(data);
    //loginUser.passenger = PassengerModel.fromMap(passengerData);


    return loginUser;
  }
  Future<void> setUserData(BuildContext context, String uid) async {
    Widget widget;
   // UserModel userData = await getUserData(uid);
    //Provider.of<UserProvider>(context, listen: false).setUser(userData);
    FutureBuilder(
      future: UserService().getUserData(uid),
      builder: (context, snapshot) {
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        if (snapshot.connectionState == ConnectionState.done) {
          widget = userProvider.setUser(snapshot.data?? UserModel());
          return widget; // or any other widgets you want to show
        } else {
          return const CircularProgressIndicator();
        }
      },
    );


    /*
    UserModel userData = await getUserData(uid);
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.setUser(userData);
    * */
  }
/*
  Future<void> setUserData(BuildContext context,String uid) async {
    UserModel userData = await getUserData(uid);
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.setUser(userData);
  }*/
//...
}