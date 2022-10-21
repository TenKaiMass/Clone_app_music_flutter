import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_app/storage.dart';

import 'data_struct.dart';

class FireBase extends StatefulWidget {
  const FireBase({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => UsicData();
}

class UsicData extends State<FireBase> {
  final Stream<QuerySnapshot> _musicStream = FirebaseFirestore.instance
      .collection("music_bank")
      .snapshots(includeMetadataChanges: true);
  final Stockage stockage = Stockage();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _musicStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return ListTile();
          }).toList(),
        );
      },
    );
  }

  Future insertMyData(MyData music) async {
    final db = FirebaseFirestore.instance.collection("music_bank").doc();
    music.id = db.id;
    await db.set(music.toMap());
  }

  void updateMyData(MyData musicBank) async {
    void deleteMyData(int id) async {}
  }

  // Stream<List<MyData>> readAll() =>
  //     FirebaseFirestore.instance
  //     .collection("music_bank")
  //     .snapshots()
  //     .map((snapshot) => snapshot.docs.map((doc) => MyData.fromMap(doc.data()));
}
