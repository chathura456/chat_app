

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/screens.dart';
import 'package:chat_app/screens/auth_setup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app/provider/get_userData.dart';

import '../Model/user_model.dart';

class UserProvider extends ChangeNotifier {
  late UserModel _user;

  UserModel get user => _user;

  setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }
}

