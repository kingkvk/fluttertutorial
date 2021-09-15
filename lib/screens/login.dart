import 'package:flutter/material.dart';
import 'package:fluttertutorial/screens/game.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:const Text("Login Page"),
      ),
      body: ElevatedButton(
        child:const Text("Move to Game Page"),
        onPressed: (){
         Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>const GamePage()),
  );
      },)
    );
  }
}