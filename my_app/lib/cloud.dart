import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FireBase extends StatefulWidget {
  const FireBase({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => UsicData();
}

class UsicData extends State<FireBase> {
  final Stream<QuerySnapshot> _musicStream = FirebaseFirestore.instance
      .collection("music_bank")
      .snapshots(includeMetadataChanges: true);
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
}
