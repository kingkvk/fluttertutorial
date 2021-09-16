import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertutorial/models/score.dart';
import 'package:fluttertutorial/screens/login.dart';

class LeaderBoard extends StatefulWidget {
  const LeaderBoard({Key? key}) : super(key: key);

  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final textcontroller = TextEditingController();
  final dbRef = FirebaseDatabase.instance.reference().child("HighScore");
  final Future<FirebaseApp> _future = Firebase.initializeApp();

  List responseString = [];
  List<Scores> scores = [];
  List<Scores> finalscores = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    responseString = [];
    dbRef.once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) {
        setState(() {
          responseString.add(values);
        });
      });

      // print(responseString);

      responseString.forEach((element) {
        setState(() {
          scores.add(Scores(int.parse(element.toString().substring(8, 10)),
              element.toString().substring(17, element.toString().length - 1)));
        });
      });

      setState(() {
        scores.sort((a, b) => a.score.compareTo(b.score));
        scores = scores.reversed.toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Leaderboard"),
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
      body: FutureBuilder(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    itemCount: scores.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          margin: const EdgeInsets.all(5),
                          padding: EdgeInsets.all(30),
                          height: 100,
                          color: Colors.grey.shade100,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(scores[index].name),
                              Text(scores[index].score.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                            ],
                          ));
                    }),
              );
            }
          }),
    );
  }
}
