import 'package:firebase_miniproject_1/subscreen.dart/team.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Commonscreen extends StatelessWidget {
   Commonscreen({super.key,required this.name,required this.doc1});
// ignore: prefer_typing_uninitialized_variables
final name;
// ignore: prefer_typing_uninitialized_variables
var doc1;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.teal,
            title: Text(name),
            bottom: TabBar(tabs: [
              Tab(
                text: 'Team',
              ),
              Tab(
                text: 'matches',
              ),
              Tab(
                text: 'players',
              )
            ]),
          ),
          body: TabBarView(children: [
            Teamscreen(doc1: doc1,),
            Center(
              child: Text('team'),
            ),
            Center(
              child: Text('team'),
            )
          ]),
        ));
  }
}
