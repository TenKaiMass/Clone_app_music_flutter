

import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';

// class ImageRessources extends StatefulWidget{

//     const ImageRessources({Key? key}) : super(key: key);
//   @override
//   State<StatefulWidget> createState() => Storage();
// }

class Stockage {//extends State<ImageRessources>{
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<firebase_storage.ListResult> listMusic() async {
    firebase_storage.ListResult res = await storage.ref('music').listAll();
    res.items.forEach((firebase_storage.Reference ref) {
      print('items : $ref');
    });
    return res;
  }

  Future<firebase_storage.ListResult> listCover() async {
    firebase_storage.ListResult res = await storage.ref('assets').listAll();

    res.items.forEach((firebase_storage.Reference ref) {
      //print(ref.fullPath);
      // print('items : $');
    });
    return res;
  }

  Future<String> getItemFromCloud(String fullPath) async {
   // print(fullPath);
    String item = await storage.ref(fullPath).getDownloadURL();
    return item;
  }

  // @override
  // Widget build(BuildContext context) {
  //   return FutureBuilder(
  //     future: this.listMusic(),
  //     builder: (BuildContext context,
  //         AsyncSnapshot<firebase_storage.ListResult>
  //             snapshot) {
  //       if (snapshot.hasData) {
  //         var datas = snapshot.data;
  //         return ListView.builder(
  //           itemCount:
  //               datas!.items.length, //datas.length,
  //           itemBuilder: (context, index) {
  //             final data = datas.items[index].name;
  //             return Container(
  //               height: 500,
  //               child: Text(data),
  //             );
  //           },
  //         );
  //       } else if (snapshot.connectionState ==
  //           ConnectionState.waiting) {
  //         return Center(
  //             child: CircularProgressIndicator());
  //       } else {
  //         print(snapshot.error.toString());
  //         return Text("on est dans le pb " +
  //             snapshot.error.toString());
  //       }
  //     },
  //   );
  // }
}
