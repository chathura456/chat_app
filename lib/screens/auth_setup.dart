import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app/screens.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> createUser({required String email, required String password})async{
    await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> loginUser({required String email, required String password})async{
    await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void>signOut()async{
    await _firebaseAuth.signOut();
  }
}

class SaveData{
  final _db = FirebaseFirestore.instance;

  createUser(UserModel user) async {
    await _db.collection("Users").add(user.toJason()).whenComplete(() => Fluttertoast.showToast(msg: 'FireStore Added Success'));

  }
}