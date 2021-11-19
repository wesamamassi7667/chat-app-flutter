import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context,index){
          return Bubble(
            color: Color.fromRGBO(212, 234, 244, 1.0),
            child: Text('TODAY', textAlign: TextAlign.center, style: TextStyle(fontSize: 11.0)),
          );

        },
      ),
    );
  }
}
