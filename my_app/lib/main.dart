import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/ServiceData.dart';
import 'package:my_app/register.dart';
import 'package:my_app/storage.dart';
import 'package:my_app/utils.dart';
import 'auth.dart';
import 'data_struct.dart';
import 'cloud.dart';
import 'firebase_options.dart';
import 'lecteur.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Spotifesse',
        home: WidgetTree());
  }
}

class HomePageMutable extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePage();
  }
}

class HomePage extends State<HomePageMutable> {
  final Stream<QuerySnapshot> _musicStream = FirebaseFirestore.instance
      .collection("music_bank")
      .snapshots(includeMetadataChanges: true);
  final Stockage stockage = Stockage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: MyAppBar2(),
      body: StreamBuilder(
          stream: _musicStream,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              var datas = snapshot.data;
              return ListView.builder(
                itemCount: datas!.docs.length, //datas.length,
                itemBuilder: (context, index) {
                  final data = datas.docs[index];
                  return Container(
                      child: ItemDesigned(mydata: data, storage: stockage));
                },
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Text("on est dans le pb " + snapshot.error.toString());
            }
          }),
      bottomNavigationBar: MyBottumBar(),
    );
  }

  Future insertMyData(MyData music) async {
    final db = FirebaseFirestore.instance.collection("music_bank").doc();
    music.id = db.id;
    await db.set(music.toMap());
  }
}

class ItemDesigned extends StatefulWidget {
  const ItemDesigned({Key? key, required this.mydata, required this.storage})
      : super(key: key);
  final QueryDocumentSnapshot mydata;
  final Stockage storage;
  @override
  State<StatefulWidget> createState() => musicList();
}

class musicList extends State<ItemDesigned> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.storage.getItemFromCloud(widget.mydata['cover']),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          return GestureDetector(
              onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PlayerGestion(mydata: widget.mydata, snapshotFromDesier: snapshot),
                          fullscreenDialog: true),
                    ),
                  },
              child: Card(
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(40, 8, 20, 20),
                      child: Row(
                        children: [
                          Image.network(snapshot.data!,
                              width: 60, height: 60, fit: BoxFit.cover),
                          Container(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.mydata['titre'],
                                  style: GoogleFonts.actor(fontSize: 20),
                                ),
                                Text(widget.mydata['artiste'],
                                    style: GoogleFonts.abel(fontSize: 14)),
                              ],
                            ),
                          ),
                        ],
                      ))));
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          print(snapshot.error.toString());
          return Text("on est dans le pb " + snapshot.error.toString());
        }
      },
    );
  }
}

class MyBottumBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: Colors.deepPurpleAccent,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.pause,
            color: Colors.white,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.arrow_upward,
            color: Colors.white,
          ),
          label: 'go_music',
        ),
      ],
    );
  }
}

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth(auth: FirebaseAuth.instance).authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomePageMutable();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
