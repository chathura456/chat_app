import 'package:chat_app/screens.dart';
import 'package:chat_app/screens/second_page.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/provider/user_service.dart';
import '../provider/user_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, this.data1}) : super(key: key);
  final String? data1;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 User? user=FirebaseAuth.instance.currentUser;
  UserModel loginUser = UserModel();
  PassengerModel passenger = const PassengerModel();
  //String? data1;

  Future<void>signOut()async{
    await FirebaseAuth.instance.signOut();
  }
/*
 @override
 void didChangeDependencies() {
   super.didChangeDependencies();
   UserService().setUserData(context, user!.uid);
   print('done');
 }*/

  @override
  void initState() {
    super.initState();
    var db = FirebaseFirestore.instance.collection("Users").doc(user!.uid);
    db.get().then((value) {
      loginUser= UserModel.fromMap(value.data());
      db.collection('Passenger').doc(user!.uid).get().then((value1) => {
        loginUser.passenger = PassengerModel.fromMap(value1.data())
      });
      setState(() {
        Provider.of<UserProvider>(context, listen: false).setUser(loginUser);
      });
    } );
    /*
    * FirebaseFirestore.instance.collection("Users").doc(user!.uid).get().then((value) {
      loginUser= UserModel.fromMap(value.data());
      setState(() {
        Provider.of<UserProvider>(context, listen: false).setUser(loginUser);
      });
    } );
    * */

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text('Home Page'),automaticallyImplyLeading: false,),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50,),
              ElevatedButton(onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                        const SecondPage()));

              }, child: const Text('Get Data')),
              const SizedBox(height: 50,),
              Text('${widget.data1}'),
              const SizedBox(height: 50,),
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

 /*getUserData(){

    /*try{
      final userRef= FirebaseFirestore.instance.collection("Users").doc(user?.uid);
      await userRef.get().then((value) {
        Map<String, dynamic>? data = value.data();
        UserModel user2 = UserModel(
            password: data?['Password'],
            fullName: data?['FullName'],
            type: data?['Type'],
            phone: data?['Phone'],
            email: data?['Email'],
            userid: data?['UserID']);
        //final data = value.data();
        //data1= data?['FullName'];
       data1 = user2.fullName;


      },
        onError: (e) => print("Error getting document: $e"),);
    }catch(e){
      print("Error getting document: $e");
    }*/
  }*/
}
