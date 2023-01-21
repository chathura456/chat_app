import 'package:chat_app/screens.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:chat_app/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>(debugLabel: '_loginscreenkey');
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page',),automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _loginFormKey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      RoundedInputField2(
                        controller: emailController,
                        hintText: 'Enter Your Email',
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
                      const SizedBox(
                        height: 20,
                      ),
                      RoundedInputField2(
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          RegExp regex = RegExp(r'^.{6,}$');
                          if (value!.isEmpty) {
                            return ("Password is required for login");
                          }
                          if (!regex.hasMatch(value)) {
                            return ("Please Enter a Valid Password(Min, 6 Characters)");
                          }
                          return null;
                        },
                        controller: passwordController,
                        hintText: 'Enter your Password',
                        isPassword: true,
                        icon: Icons.key,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            signIn();
                           /* Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));*/
                          },
                          child: const Text('Login')),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/register');
                            /*
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterPage()));*/
                          },
                          child: const Text(
                            'Register Page',
                            style: TextStyle(fontSize: 20),
                          ))
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
  Future signIn() async {
    final isValid = _loginFormKey.currentState!.validate();
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

     await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim());


    } on FirebaseAuthException catch (e) {

      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: 'You Entered wrong email!!');
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: 'You Entered wrong Password!!');
      }
        Fluttertoast.showToast(msg: '${e.message}');

    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
