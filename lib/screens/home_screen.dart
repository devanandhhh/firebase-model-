// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_miniproject_1/screens/common_screen.dart';

import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  TextEditingController nameController = TextEditingController();

  TextEditingController ageController = TextEditingController();

  String? editingItmId;
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[100],
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'Complete the Form',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: formkey,
          child: Column(children: [
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'requried';
                }
                return null;
              },
              controller: nameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  hintText: 'Name'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'requried';
                }
                return null;
              },
              controller: ageController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  hintText: 'Age '),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () async {
                  if (formkey.currentState!.validate()) {
                    try {
                        await FirebaseFirestore.instance
                            .collection('details')
                            .add({
                          'name': nameController.text,
                          'age': ageController.text
                        });
                      nameController.clear();
                      ageController.clear();
                      print('Data added successfully');
                    } catch (e) {
                      print('Error adding data: $e');
                    }
                  }
                },
                child: const Text(
                  'Save',
                )),
            Expanded(
                child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('details').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text('no data available'),
                  );
                }

                return ListView.separated(
                    itemBuilder: (context, index) {
                      var docs = snapshot.data!.docs[index];
                      String name = docs['name'] ?? '';
                      String age = docs['age'] ?? '';
                      TextEditingController nameController =
                          TextEditingController(text: docs['name']);
                      TextEditingController ageController =
                          TextEditingController(text: docs['age']);
                      return ListTile(
                        onTap: () {
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>Commonscreen(name: name,doc1: docs.id,)));
                        },
                        title: Text(name),
                        subtitle: Text(age),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Edit data'),
                                          content: Column(children: [
                                            TextFormField(
                                              controller: nameController,
                                              decoration: InputDecoration(
                                                  labelText: 'Name'),
                                            ),
                                            TextFormField(
                                              controller: ageController,
                                              decoration: InputDecoration(
                                                  labelText: 'Age'),
                                            ),
                                            // Text('Name :$name'),
                                            // Text('Age:$age')
                                          ]),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Cancel'),
                                            ),
                                            TextButton(
                                                onPressed: () async {
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('details')
                                                      .doc(docs.id)
                                                      .update({
                                                    'name': nameController.text,
                                                    'age': ageController.text
                                                  });

                                                  nameController.clear();
                                                  ageController.clear();

                                                  Navigator.of(context).pop();
                                                  print(
                                                      'data edited sucessfully');
                                                },
                                                child: Text('Save'))
                                          ],
                                        );
                                      });
                                  // editingItmId = docs.id;
                                  // nameController.text = name;
                                  // ageController.text = age;
                                },
                                icon: Icon(Icons.edit)),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () async {
                                await FirebaseFirestore.instance
                                    .collection('details')
                                    .doc(docs.id)
                                    .delete();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: snapshot.data!.docs.length);
              },
            ))
          ]),
        ),
      ),
    );
  }

  void addEvent({String? name, String? age}) async {}
}





















































// //import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';

// class HomeScreen extends StatelessWidget {
//   HomeScreen({Key? key}) : super(key: key);

//   final nameController = TextEditingController();
//   final ageController = TextEditingController();
//   final formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.amber[100],
//       appBar: AppBar(
//         backgroundColor: Colors.teal,
//         title: Text(
//           'Complete the Form',
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Form(
//           key: formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: nameController,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   hintText: 'Name',
//                 ),
//               ),
//               SizedBox(height: 10),
//               TextFormField(
//                 controller: ageController,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   hintText: 'Age',
//                 ),
//               ),
//               SizedBox(height: 10),
//               ElevatedButton(
//                 onPressed: () async {
//                   if (formKey.currentState!.validate()) {
//                     // Call the addEvent method to save data to Firebase
//                     addEvent(
//                       nameController.text,
//                       ageController.text,
//                     );
//                   }
//                 },
//                 child: Text('Save'),
//               ),
//               Expanded(
//                 child: FutureBuilder(
//                   future: fetchDataFromFirebase(),
//                   builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return CircularProgressIndicator();
//                     } else if (snapshot.hasError) {
//                       return Text('Error: ${snapshot.error}');
//                     } else {
//                       // Display data using ListView.builder
//                       return ListView.builder(
//                         itemCount: snapshot.data!.length,
//                         itemBuilder: (context, index) {
//                           return ListTile(
//                             title: Text('Name: ${snapshot.data![index]['name']}'),
//                             subtitle: Text('Age: ${snapshot.data![index]['age']}'),
//                           );
//                         },
//                       );
//                     }
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<List<Map<String, dynamic>>> fetchDataFromFirebase() async {
//     // Fetch data from Firebase and return a List<Map<String, dynamic>>
//     DatabaseReference eventsRef = FirebaseDatabase.instance.ref().child('events');
//     DataSnapshot snapshot = (await eventsRef.once()) as DataSnapshot;

//     List<Map<String, dynamic>> dataList = [];
//     Map<dynamic, dynamic>? dataMap = snapshot.value as Map?;

//     if (dataMap != null) {
//       dataMap.forEach((key, value) {
//         dataList.add({
//           'name': value['name'],
//           'age': value['age'],
//         });
//       });
//     }

//     return dataList;
//   }

//   void addEvent(String name, String age) {
//     FirebaseDatabase database = FirebaseDatabase.instance;
//     DatabaseReference eventsRef = database.ref().child('events');
//     String? eventId = eventsRef.push().key;
//     DatabaseReference eventRef = eventsRef.child(eventId!);
//     eventRef.set({
//       'name': name,
//       'age': age,
//     });

//     // Clear text fields after saving
//     nameController.clear();
//     ageController.clear();
//   }
// }
