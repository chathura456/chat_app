import 'package:chat_app/screens/conductor_home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:chat_app/screens.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';
/*
class SelectLogin extends StatelessWidget {
  const SelectLogin({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    UserService userService = UserService();

    return StreamBuilder<User?>(
      builder: (context,snapshot){
      if(snapshot.hasData ){
        //return HomePage();
        //return checkType(context);
       return StreamBuilder(
            builder: (BuildContext context,AsyncSnapshot<DocumentSnapshot> snapshot){
              if(snapshot.hasData){
                  return FutureBuilder(
                    future: userService.getUserData(snapshot.data!.id),
                    builder: (context, AsyncSnapshot<UserModel?> userSnapshot) {
                      if (userSnapshot.hasError) {
                        return Text('Error: ${userSnapshot.error}');
                      }
                      if (userSnapshot.hasData) {
                        UserModel? user1 = userSnapshot.data;

                        if(user1?.type=='Passenger'){
                          return HomePage();
                        }else if(user1?.type=='Conductor'){
                          return const ConductorHome();
                        }
                      }else{
                        return const SelectUserType();
                      }
                      return HomePage();
                    },
                  );
              }return const ConductorHome();
            },
          stream: FirebaseFirestore.instance.collection("Users").doc(snapshot.data?.uid).snapshots(),
        );
      } else if(snapshot.hasError){
        return const Center(child: Text('wrong credentials'));
      }
      else{
        return const WelcomePage();
      }
    },
      stream: FirebaseAuth.instance.authStateChanges(),
    );
  }

  /*Future checkType (BuildContext context) async {

    final User? user = Auth().currentUser;
    if(user!=null){
     var docRef = FirebaseFirestore.instance.collection('/Users').doc(user.uid);
     docRef.get().then((value) {
       final data = value.data() as UserModel;
       if(data.type=='Passenger'){
         return HomePage();
       }
       return const WelcomePage();
     });

    }
  }*/
}*/

class SelectLogin extends StatefulWidget {
  const SelectLogin({Key? key}) : super(key: key);

  @override
  State<SelectLogin> createState() => _SelectLoginState();
}

class _SelectLoginState extends State<SelectLogin> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return StreamBuilder(
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasData) {
                //final userType = snapshot.data?.get('Type');
               UserModel loginUser=UserModel();
               loginUser= UserModel.fromMap(snapshot.data);
               //UserService userService = UserService();
               //User? user1=FirebaseAuth.instance.currentUser;
                if (loginUser.type == 'Passenger') {
                  //Provider.of<UserProvider>(context, listen: false).setUser(loginUser);
                 /* return FutureBuilder(
                      builder: (context,userSnapshot){
                        if (userSnapshot.hasData) {
                          Provider.of<UserProvider>(context, listen: false).setUser(loginUser);
                          print('finish');
                          // pass the user data to the UserProvider
                          //Provider.of<UserProvider>(context, listen: false).setUser(user);
                          return HomePage(data1: loginUser.fullName,);}
                        return HomePage(data1: loginUser.fullName,);
                      },
                  future: FirebaseFirestore.instance.collection('Users').doc(user1!.uid).get(),
                  );*/
                  return HomePage(data1: loginUser.fullName,);
                } else if (loginUser.type == 'Conductor') {
                  return const ConductorHome();
                }
                else {
                  return const SelectUserType();
                }
              }
              return const SelectUserType();
            },
            stream: FirebaseFirestore.instance.collection("Users").doc(
                snapshot.data?.uid).snapshots(),
          );
        } else if (snapshot.hasError) {
          return const Center(child: Text('wrong credentials'));
        }
        else {
          return const WelcomePage();
        }
      },
      stream: FirebaseAuth.instance.authStateChanges(),
    );
  }
}

/*
class SelectLogin extends StatelessWidget {
  const SelectLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return StreamBuilder(
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasData) {
                final userType = snapshot.data?.get('Type');
               UserModel loginUser=const UserModel();
                loginUser= UserModel.fromMap(snapshot.data);
                //Provider.of<UserProvider>(context, listen: false).setUser(loginUser);

                if (loginUser.type == 'Passenger') {
                  return HomePage(data1: loginUser.fullName,);
                } else if (userType == 'Conductor') {
                  return const ConductorHome();
                }
                else {
                  return const SelectUserType();
                }
              }
              return const SelectUserType();
            },
            stream: FirebaseFirestore.instance.collection("Users").doc(
                snapshot.data?.uid).snapshots(),
          );
        } else if (snapshot.hasError) {
          return const Center(child: Text('wrong credentials'));
        }
        else {
          return const WelcomePage();
        }
      },
      stream: FirebaseAuth.instance.authStateChanges(),
    );
  }
}
* */


/*
class SelectLogin extends StatelessWidget {
  const SelectLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return StreamBuilder(
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasData) {
                final userType = snapshot.data?.get('Type');
                /*User? user=FirebaseAuth.instance.currentUser;
                UserModel loginUser=const UserModel();
                FirebaseFirestore.instance.collection("Users").doc(user!.uid).get().then((value) {
                  loginUser= UserModel.fromMap(value.data());
                } );*/

                if (userType == 'Passenger') {
                  return const HomePage();
                } else if (userType == 'Conductor') {
                  return const ConductorHome();
                }
                else {
                  return const SelectUserType();
                }
              }
              return const SelectUserType();
            },
            stream: FirebaseFirestore.instance.collection("Users").doc(
                snapshot.data?.uid).snapshots(),
          );
        } else if (snapshot.hasError) {
          return const Center(child: Text('wrong credentials'));
        }
        else {
          return const WelcomePage();
        }
      },
      stream: FirebaseAuth.instance.authStateChanges(),
    );
  }
}
*/

/*
class SelectLogin extends StatelessWidget {
  const SelectLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<User?>(
      builder: (context,snapshot){
      if(snapshot.hasData ){
        //return HomePage();
        //return checkType(context);
       return StreamBuilder(
            builder: (BuildContext context,AsyncSnapshot<DocumentSnapshot> snapshot){
              if(snapshot.hasData){
                final user = snapshot.data?.get('Type');
                if(user=='Passenger'){
                  return HomePage();
                }else{
                  return const ConductorHome();
                }
              }return const ConductorHome();
            },
          stream: FirebaseFirestore.instance.collection("Users").doc(snapshot.data?.uid).snapshots(),
        );
      } else if(snapshot.hasError){
        return const Center(child: Text('wrong credentials'));
      }
      else{
        return const WelcomePage();
      }
    },
      stream: FirebaseAuth.instance.authStateChanges(),
    );
  }

  /*Future checkType (BuildContext context) async {

    final User? user = Auth().currentUser;
    if(user!=null){
     var docRef = FirebaseFirestore.instance.collection('/Users').doc(user.uid);
     docRef.get().then((value) {
       final data = value.data() as UserModel;
       if(data.type=='Passenger'){
         return HomePage();
       }
       return const WelcomePage();
     });

    }
  }*/
}
 */
















/*
class SelectLogin extends StatefulWidget {
  const SelectLogin({Key? key}) : super(key: key);

  @override
  State<SelectLogin> createState() => _SelectLoginState();
}

class _SelectLoginState extends State<SelectLogin> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(builder: (context,snapshot){
      if(snapshot.hasData){
        return HomePage();
      }else{
        return const LoginPage();
      }
    },
    stream: Auth().authStateChanges,
    );
  }
}*/
