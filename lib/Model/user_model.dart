import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app/screens.dart';

class UserModel{
  final String? id;
  final String? fullName;
  final String? email;
  final String? password;
  final String? phone;
  final String? type;
  final String? userid;
  final String? uid;
  PassengerModel? passenger;
  ConductorModel? conductor;


  UserModel(
  {
    this.id,
    this.email,
    this.password,
    this.fullName,
    this.type,
    this.phone,
    this.userid,
    this.uid,
    this.passenger,
    this.conductor
  });

  Map<String,dynamic>toJason()=>{
      "FullName":fullName,
      "Email":email,
      "Phone":phone,
      "Password":password,
      "Type":type,
      "UserID":userid,
    "Uid":uid,
};
  Map<String,dynamic>updateJason()=>{
    "Type":type,
  };

  Map<String,dynamic>updateIdJason()=>{
    "UserID":userid,
  };

  factory UserModel.fromMap(json){
    return UserModel(
        password: json['Password'],
        fullName: json['FullName'],
        type: json['Type'],
        phone: json['Phone'],
        email: json['Email'],
        userid: json['UserID'],
      uid: json['Uid'],
     //passenger: json['Passenger'] != null ? PassengerModel.fromMap(json['Passenger']) : null,
    );
  }

 /* static UserModel fromJson(Map<String,dynamic>json)=>UserModel(
      password: json['Password'],
      fullName: json['FullName'],
      type: json['Type'],
      phone: json['Phone'],
    email: json['Email'],
    userid: json['UserID']
  );*/
}
/*
class UserService {
  Future<UserModel?> getUserData(String uid) async {
    var userDocument = await FirebaseFirestore.instance.collection("Users").doc(uid).get();
    if(userDocument.exists){
          (Map<String?, dynamic> json)=> UserModel(
          password: json['Password'],
          fullName: json['FullName'],
          type: json['Type'],
          phone: json['Phone'],
          email: json['Email'],
          userid: json['UserID']
      );
    } else {
      return null;
    }
  }
}*/

