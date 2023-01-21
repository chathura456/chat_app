import 'package:chat_app/main.dart';
import 'package:chat_app/screens.dart';
import 'package:flutter/material.dart';

class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;

    switch (settings.name){
      case '/':
        return MaterialPageRoute(builder: (_)=>const SelectLogin());
      case '/login':
        return MaterialPageRoute(builder: (_)=>const LoginPage());
      case '/register':
        return MaterialPageRoute(builder: (_)=>const RegisterPage());
      case '/home':
        return MaterialPageRoute(builder: (_)=>HomePage());
      case '/welcome':
        return MaterialPageRoute(builder: (_)=>const WelcomePage());
      default:
        return _errorRoute();

    }
  }

  static Route<dynamic> _errorRoute(){
    return MaterialPageRoute(builder: (_){
      return Scaffold(
        appBar: AppBar(title: const Text('Error page'),),
    body: const Center(
    child: Text('Something went wrong!!'),
    ),
    );
    });
  }
}

