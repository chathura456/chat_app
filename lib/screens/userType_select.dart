import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/screens.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../main.dart';

class SelectUserType extends StatefulWidget {
  const SelectUserType({Key? key}) : super(key: key);

  @override
  State<SelectUserType> createState() => _SelectUserTypeState();
}

class _SelectUserTypeState extends State<SelectUserType> {
  final User? user = Auth().currentUser;
  String _buttonValue='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Account Type'),),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Column(
                children: [
                  const SizedBox(height: 20,),
                  ListTile(
                    title: const Text('Passenger'),
                    leading: Radio(
                      value: 'Passenger',
                      groupValue: _buttonValue,
                      onChanged: ( value) {
                        setState(() {
                          _buttonValue = 'Passenger';
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 20,),
                  ListTile(
                    title: const Text('Conductor'),
                    leading: Radio(
                      value: 'Conductor',
                      groupValue: _buttonValue,
                      onChanged: ( value) {
                        setState(() {
                          _buttonValue = 'Conductor';
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 20,),
                  ElevatedButton(onPressed: (){
                    if(_buttonValue!=''){
                      updateAccType();
                    }else{
                      Fluttertoast.showToast(msg: 'Please Select Account Type');
                    }

                  }, child: const Text('Confirm')),
                  const SizedBox(height: 20,),
                  Text(_buttonValue),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future updateAccType() async{
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try{
      final userRef= FirebaseFirestore.instance.collection("Users").doc(user?.uid);

      /*const passenger = PassengerModel(
          package: '123',
          points: '256'
      );*/
      final currentUser = UserModel(
        type: _buttonValue,
        //passenger: passenger
      );
      await userRef.update(currentUser.updateJason());
     if(_buttonValue == 'Passenger'){
        const passenger = PassengerModel(
          package: '123',
          points: '256'
        );
        await userRef.collection('Passenger').doc(user?.uid).set(passenger.toJason());
      }
      else if(_buttonValue == 'Conductor'){
        const conductor = ConductorModel(
            route: '4654',
          busNo: '4554'
        );
        await userRef.collection('Conductor').doc(user?.uid).set(conductor.toJason());
      }
    }on FirebaseException catch (e){
      Fluttertoast.showToast(msg: '${e.message}');
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
