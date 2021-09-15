import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GamePage extends StatefulWidget {
  const GamePage({ Key? key }) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int? diceno =0;
  int? chances =10;
  bool gameover =true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:const Text("Gameplay Page"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(chances!.toString()),
          Center(
            child: Container(
              height: 150,
              width:150,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius:BorderRadius.circular(10)),
                child: Center(child: Text(diceno.toString(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 50,color: Colors.white),),)
      ),
          ),
          const SizedBox(height: 50,),
          ElevatedButton(
        
            onPressed:gameover ?_rolldice:null,
            child:const Text("Roll the Dice"),),

        ],
      ),    
    );
  }
  _rolldice(){
    chances = (chances! -1);
    int dicevalue = (Random().nextInt(6)+1);
    if(chances == 0){
      setState(() {
        gameover=false;
      });
    }

    setState(() {
      diceno=dicevalue;
    });
  }
}