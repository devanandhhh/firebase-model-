import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_miniproject_1/subscreen.dart/add_team.dart';
import 'package:firebase_miniproject_1/subscreen.dart/refactoring/reuse.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Teamscreen extends StatefulWidget {
  Teamscreen({super.key, this.doc1});
// ignore: prefer_typing_uninitialized_variables
  var doc1;

  @override
  State<Teamscreen> createState() => _TeamscreenState();
}

class _TeamscreenState extends State<Teamscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Addteam(
                        docss: widget.doc1,
                      )));
        },
        child: Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('details')
            .doc(widget.doc1)
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
                String image = doc2['image'];
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
                return ListTile(
                  title: Text(team),
                  subtitle: Text(place),
                  trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                    IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (ctx) {
                                return AlertDialog(
                                  title: const Text('Edit Data'),
                                  content: StatefulBuilder(
                                    builder: (context, setState) {
                                      return  SingleChildScrollView(
                                      child: Column(children: [
                                        GestureDetector(onTap: ()async{
                                           
                                          String? newpic=await pickImageFromGallery();
                                         setState(() {
                                            image=newpic!;
                                          });
                                        },
                                          child: CircleAvatar(
                                            
                                            radius: 55,
                                            backgroundColor: Colors.red,
                                            child: ClipOval(
                                                child: Image.file(
                                              File(image),
                                              fit: BoxFit.cover,
                                              width: 100,
                                              height: 100,
                                            )),
                                          ),
                                        ),
                                        sizedbox10(),
                                        TextFormField(
                                          controller: teamController,
                                          decoration:const InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'Team name'),
                                        ),
                                        sizedbox10(),
                                        TextFormField(
                                          controller: managerController,
                                          decoration:const InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'manger name'),
                                        ),
                                        sizedbox10(),
                                        TextFormField(
                                          controller: phoneController,
                                          decoration:const InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'phone number'),
                                        ),
                                        sizedbox10(),
                                        TextFormField(
                                          controller: placeController,
                                          decoration:const InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'place name'),
                                        ),
                                      ]),
                                    );
                                    },
                             
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('cancel')),
                                    TextButton(
                                        onPressed: () async {
                                          await FirebaseFirestore.instance
                                              .collection('details')
                                              .doc(widget.doc1)
                                              .collection('team')
                                              .doc(doc2.id)
                                              .update({
                                            'teams': teamController.text,
                                            'manager': managerController.text,
                                            'phone': phoneController.text,
                                            'place': placeController.text,
                                            'image':image
                                          });
                                          teamController.clear();
                                          managerController.clear();
                                          phoneController.clear();
                                          placeController.clear();
                                         
                                        
                                          // ignore: use_build_context_synchronously
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'Updated date sucessfully')));
                                                       // ignore: use_build_context_synchronously
                                                        Navigator.pop(context);
                                        },
                                        child:const Text('save'))
                                  ],
                                );
                              });
                        },
                        icon:const Icon(Icons.edit)),
                    IconButton(
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection('details')
                              .doc(widget.doc1)
                              .collection('team')
                              .doc(doc2.id)
                              .delete();
                        },
                        icon:const Icon(Icons.delete))
                  ]),
                );
              },
              separatorBuilder: (context, index) =>const Divider(),
              itemCount: snapshot.data!.docs.length);
        },
      ),
    );
  }
  
  // Future<String?> pickImageFromGallery() async {
  //   final pickedImage =
  //       await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (pickedImage != null) {
  //     return pickedImage.path;
  //   }
  //   return null;
  // }
}
