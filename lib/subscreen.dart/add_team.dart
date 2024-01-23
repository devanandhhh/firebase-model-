import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_miniproject_1/subscreen.dart/refactoring/reuse.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class Addteam extends StatefulWidget {
  Addteam({super.key, this.docss});
  var docss;

  @override
  State<Addteam> createState() => _AddteamState();
}

class _AddteamState extends State<Addteam> {
  final teamController = TextEditingController();

  final managerController = TextEditingController();

  final phoneController = TextEditingController();

  final placeController = TextEditingController();

  final globalkey = GlobalKey<FormState>();
  String? selectImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Team')),
      body: SingleChildScrollView(
        child: Column(children: [
          CircleAvatar(
            radius: 70,
            backgroundColor: Colors.blue,
            child: GestureDetector(
              onTap: () async {
                String? imagepick = await pickImageFromGallery();
                setState(() {
                  selectImage=imagepick;
                });
              },
              child: selectImage != null
                  ? ClipOval(
                      child: Image.file(
                        File(selectImage!),
                        fit: BoxFit.cover,
                        width: 150,
                        height: 150,
                      ),
                    )
                  : null,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Form(
              key: globalkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sizedbox10(),
                  Text('Team Name'),
                  sizedbox10(),
                  TextFormField(
                    controller: teamController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Team name is required';
                      }
                    },
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                  sizedbox10(),
                  Text(
                    'Manger name',
                  ),
                  sizedbox10(),
                  TextFormField(
                      controller: managerController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'manager name is required';
                        }
                      },
                      decoration:
                          InputDecoration(border: OutlineInputBorder())),
                  sizedbox10(),
                  Text('phone Number'),
                  sizedbox10(),
                  TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'phone number  is required';
                        }
                      },
                      decoration:
                          const InputDecoration(border: OutlineInputBorder())),
                  sizedbox10(),
                  const Text('Place'),
                  sizedbox10(),
                  TextFormField(
                      controller: placeController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'place name is required';
                        }
                      },
                      decoration: const InputDecoration(border: OutlineInputBorder()))
                ],
              ),
            ),
          ),
          sizedbox10(),
          GestureDetector(
            onTap: () async {
              if (globalkey.currentState!.validate()) {
                await FirebaseFirestore.instance
                    .collection('details')
                    .doc(widget.docss)
                    .collection('team')
                    .add({
                  'teams': teamController.text,
                  'manager': managerController.text,
                  'phone': phoneController.text,
                  'place': placeController.text,
                  'image':selectImage
                });
                teamController.clear();
                managerController.clear();
                phoneController.clear();
                placeController.clear();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Sucessfully added'),
                  backgroundColor: Colors.green,
                ));
                setState(() {
                  selectImage= null;
                });
              }
            },
            child: Container(
              height: 60,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(9)),
              child: Center(
                  child: Text(
                'Add Team',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )),
            ),
          )
        ]),
      ),
    );
  }


}
  Future<String?> pickImageFromGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      return pickedImage.path;
    }
    return null;
  }
