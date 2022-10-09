import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/ServiceData.dart';
import 'data_struct.dart';
import 'cloud.dart';
import 'firebase_options.dart';
import 'lecteur.dart';

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
        home: HomePageMutable());
  }
}

class HomePageMutable extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePage();
    //return HomeFireBase();
  }
}

class HomePage extends State<HomePageMutable> {
  final Stream<QuerySnapshot> _musicStream = FirebaseFirestore.instance
      .collection("music_bank")
      .snapshots(includeMetadataChanges: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: MyAppBar2(),
      body: StreamBuilder(
          stream: _musicStream,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              //List<MyData>? datas = snapshot.data
              var datas = snapshot.data;
              return ListView.builder(
                itemCount: datas!.docs.length, //datas.length,
                itemBuilder: (context, index) {
                  final data = datas.docs[index];
                  return Container(child: ItemDesigned(mydata: data));
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
}

class ItemDesigned extends StatelessWidget {
  const ItemDesigned({Key? key, required this.mydata}) : super(key: key);
  final QueryDocumentSnapshot mydata;
  //final MyData mydata;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PlayerGestion(mydata: mydata),
              fullscreenDialog: true),
        ),
      },
      child: Card(
          child: Container(
              padding: const EdgeInsets.fromLTRB(40, 8, 20, 20),
              child: Row(
                children: [
                  Image.asset(mydata['cover'],
                      width: 60, height: 60, fit: BoxFit.cover),
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          mydata['titre'],
                          style: GoogleFonts.actor(
                              // color:
                              //     mydata['etat'] ? Colors.deepPurple : Colors.black,
                              fontSize: 20),
                        ),
                        Text(mydata['artiste'],
                            style: GoogleFonts.abel(fontSize: 14)),
                      ],
                    ),
                  ),
                ],
              ))),
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

class MyAppBar2 extends StatelessWidget implements PreferredSizeWidget {
  Size get preferredSize => new Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "uSic",
          selectionColor: Colors.white,
          style: GoogleFonts.amiko(fontSize: 25),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const Scaffold(
                    body: Center(child: Text("Not Implement Yet!")),
                  ),
                ),
              );
            },
          ),
        ]);
  }
}
