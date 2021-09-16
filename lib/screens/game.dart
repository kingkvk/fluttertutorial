import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertutorial/screens/login.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference dbRef =
      FirebaseDatabase.instance.reference().child("HighScore");

  int? diceno = 0;
  int? chances = 10;
  bool gameover = true;
  int? score = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Gameplay Page"),
        actions: [
          IconButton(
              onPressed: () {
                auth.signOut().then((res) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                      (Route<dynamic> route) => false);
                });
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            Container(
              height: 80,
              color: Colors.blue,
              child: Center(
                child: Text(
                  auth.currentUser!.email.toString(),
                  style: const TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            ListTile(
              tileColor: Colors.purple,
              title: const Text(
                "Leaderboard",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              onTap: () {},
            )
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text("Total Chances Left",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                const SizedBox(
                  width: 10,
                ),
                Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red),
                    child: Center(
                      child: Text(chances.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.white)),
                    )),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text("Score",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                const SizedBox(
                  width: 10,
                ),
                Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red),
                    child: Center(
                      child: Text(score.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.white)),
                    )),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 60,
          ),

          Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  diceno.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                      color: Colors.white),
                ),
              )),
          //const
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
            onPressed: gameover ? _rolldice : null,
            child: const Text("Roll the Dice"),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  void addData() {
    dbRef.push().set({'name': auth.currentUser!.email, 'score': score});
  }

  // Rolling Dice Function
  _rolldice() {
    chances = (chances! - 1);
    int dicevalue = (Random().nextInt(6) + 1);
    if (chances == 0) {
      setState(() {
        gameover = false;
        addData();
      });
    }

    setState(() {
      score = score! + dicevalue;
      diceno = dicevalue;
    });
  }
}
