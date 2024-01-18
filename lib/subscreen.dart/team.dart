import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_miniproject_1/subscreen.dart/add_team.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Teamscreen extends StatelessWidget {
  Teamscreen({super.key, this.doc1});
// ignore: prefer_typing_uninitialized_variables
  var doc1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Addteam(
                        docss: doc1,
                      )));
        },
        child: Icon(Icons.add),
      ),
      body: Expanded(
          child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('details')
            .doc(doc1)
            .collection('team')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No Data Available'),
            );
          }
          return ListView.separated(
              itemBuilder: (context, index) {
                 var doc2 = snapshot.data!.docs[index];

                String team = doc2['teams'];
                String manager = doc2['manager'];
                String phone = doc2['phone'];
                String place = doc2['place'];
                TextEditingController teamController =
                    TextEditingController(text: team);
                TextEditingController managerController =
                    TextEditingController(text: manager);
                TextEditingController phoneController =
                    TextEditingController(text: phone);
                TextEditingController placeController =
                    TextEditingController(text: place);
                    return ListTile(title: Text(team),
                    subtitle: Text(place),
                    );
              },
              separatorBuilder: (context, index) => Divider(),
              itemCount: snapshot.data!.docs.length);
        },
      )),
    );
  }
}
