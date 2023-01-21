import 'package:chat_app/screens.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _regFormKey = GlobalKey<FormState>(debugLabel: '_regScreenKey');
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
String? email='';
 String? password='';
 String? name;
 String? phone;
 String? newID;
 String? customID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register Page'),automaticallyImplyLeading: false,),
      body: SingleChildScrollView(
        keyboardDismissBehavior:
        ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _regFormKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 10),
                  child: Column(
                    children: [
                      const SizedBox(height: 40,),
                      RoundedInputField2(controller: nameController,hintText: 'Enter Your Name',
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        icon: Icons.person,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Please Enter your Name");
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20,),
                      RoundedInputField2(controller: emailController,hintText: 'Enter Your Email',
                        icon: Icons.email,
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Please Enter your Email");
                          }
                          if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                            return ("please Enter a Valid Email");
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20,),
                      RoundedInputField2(
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.number,
                        controller: phoneController,
                        hintText: 'Enter Your Phone Number',
                        icon: Icons.phone,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Please Enter Phone Number");
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20,),
                      RoundedInputField2(
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          RegExp regex = RegExp(r'^.{6,}$');
                          if (value!.isEmpty) {
                            return ("Password is required for register");
                          }
                          if (!regex.hasMatch(value)) {
                            return ("Please Enter a Valid Password(Min, 6 Characters)");
                          }
                          return null;
                        },
                        controller: passwordController,
                        hintText: 'Enter your Password',
                        keyboardType: TextInputType.number,
                        isPassword: true,
                        icon: Icons.key,
                      ),
                      const SizedBox(height: 20,),
                      ElevatedButton(onPressed: (){
                        signUp();


                       /* Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                const HomePage()));*/
                      }, child: const Text('Register')),
                      TextButton(onPressed: (){
                        Navigator.pushNamed(context, '/login');
                        /*Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                const LoginPage()));*/
                      }, child: const Text('Login Page',style: TextStyle(fontSize: 20),)),
                      /*Text(password!),
                      Text(email!),
                      Text('test')*/

                    ],

                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }



  Future signUp() async {
    final isValid = _regFormKey.currentState!.validate();
    if (!isValid) return;
   showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
    );
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text).then((value) async {
             final db =  FirebaseFirestore.instance;

             final sfDocRef = db.collection("Users");
             /*await sfDocRef.orderBy("UserID", descending: true).limit(1).get()
                 .then((value) {

               for (var doc in value.docs) {
                 //print(doc["first_name"]);
                 newID = doc['UserID'];
               }
             });*/
             const passenger = PassengerModel(
                 package: '123',
                 points: '256'
             );
             final newUser = UserModel(
               uid: value.user?.uid,
                 email: value.user?.email,
                 password: passwordController.text.trim(),
                 fullName: nameController.text.trim(),
                 //userid: '',
                 //type: 'Passenger',
                 phone: phoneController.text.trim());

             await FirebaseFirestore.instance.collection("Users").doc(value.user?.uid).set(newUser.toJason());
            // await FirebaseFirestore.instance.collection("Users").doc(newUser.uid).collection('PassengerData').doc(newUser.uid).set(newUser.passenger!.toJason());
             try{
               final sfDocRef = db.collection("Users").doc('counter');
               await db.runTransaction((transaction) async {
                 final snapshot = await transaction.get(sfDocRef);
                 // Note: this could be done without a transaction
                 //       by updating the population using FieldValue.increment()
                 final lastID = snapshot.get("latest");
                 newID = (int.parse(lastID)+1).toString();
                 try{
                   final userRef= FirebaseFirestore.instance.collection("Users").doc(value.user?.uid);
                   final currentUser = UserModel(
                       userid: newID
                   );
                   await userRef.update(currentUser.updateIdJason()
                   );
                 }on FirebaseException catch (e){
                   Fluttertoast.showToast(msg: '${e.message}');
                 }
                 transaction.update(sfDocRef, {"latest": newID},);
               });

             }on FirebaseException catch (e){
               Fluttertoast.showToast(msg: '${e.message}');
             }
             /*
             await db.runTransaction((transaction) async {
               final snapshot = await transaction.get(sfDocRef);
               // Note: this could be done without a transaction
               //       by updating the population using FieldValue.increment()
               final lastID = snapshot.get("latest");
               newID = (int.parse(lastID)+1).toString();
               transaction.update(sfDocRef, {"latest": newID});
             });
             await sfDocRef.get().then(
                   (DocumentSnapshot doc) {
                 final data = doc.data() as Map<String, dynamic>;
                 customID: data['latest'].toString();
                 final newUser = UserModel(
                     email: value.user?.email,
                     password: passwordController.text.trim(),
                     fullName: nameController.text.trim(),
                     userid: newID,
                     //type: 'Passenger',
                     phone: phoneController.text.trim());
                 FirebaseFirestore.instance.collection("Users").doc(value.user?.uid).set(newUser.toJason());
                 // ...
               },
               onError: (e) => print("Error getting document: $e"),
             );

*/

        });

       //await SaveData().createUser(user);

      } on FirebaseAuthException catch (e) {
          Fluttertoast.showToast(msg: '${e.message}');

      }on FirebaseException catch (e){
        Fluttertoast.showToast(msg: '${e.message}');
      }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
    //navigatorKey.currentState!.pushNamed('/home');

  }

}

