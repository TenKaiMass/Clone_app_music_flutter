import 'package:cached_network_image/cached_network_image.dart';
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
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
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
    //return HomePage();
    return HomeFireBase();
  }
}

class HomeFireBase extends State<HomePageMutable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            "uSic",
            selectionColor: Colors.white,
            style: GoogleFonts.amiko(fontSize: 25),
          )),
      body: FireBase(),
    );
  }
}

class HomePage extends State<HomePageMutable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            "uSic",
            selectionColor: Colors.white,
            style: GoogleFonts.amiko(fontSize: 25),
          )),
      body: FutureBuilder<List<MyData>>(
          future: MyDataBase.instance.musicBanks(),
          builder:
              (BuildContext context, AsyncSnapshot<List<MyData>> snapshot) {
            if (snapshot.hasData) {
              List<MyData>? datas = snapshot.data;
              return ListView.builder(
                itemCount: datas!.length,
                itemBuilder: (context, index) {
                  final data = datas[index];
                  return Dismissible(
                      key: Key(data.id.toString()),
                      onDismissed: (direction) {
                        setState(() {
                          MyDataBase.instance.deleteMyData(data.id);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("music ${data.titre} supprimé")));
                      },
                      background: Container(color: Colors.red),
                      child: ItemDesigned(mydata: data));
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
      bottomNavigationBar: MyBottumBar(),
    );
  }
}

class ItemDesigned extends StatelessWidget {
  const ItemDesigned({Key? key, required this.mydata}) : super(key: key);
  final MyData mydata;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PlayerGestion(mydata: mydata)),
        ),
      },
      child: Card(
          child: Container(
              padding: const EdgeInsets.fromLTRB(40, 8, 20, 20),
              child: Row(
                children: [
                  Image.asset(mydata.cover,
                      width: 60, height: 60, fit: BoxFit.cover),
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          mydata.titre,
                          style: GoogleFonts.actor(
                              // color:
                              //     mydata['etat'] ? Colors.deepPurple : Colors.black,
                              fontSize: 20),
                        ),
                        Text(mydata.artiste,
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
      // onTap: ((value) => {
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(builder: (context) => PlayerPage(mydata: mydata,)),
      //       ),
      //     }),
      backgroundColor: Colors.deepPurpleAccent,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.pause,
            color: Colors.white,
          ),
          label: '',
        ),
        // BottomNavigationBarItem(
        //     label: '',
        //     icon: Text(
        //       'le poulet',
        //       style: GoogleFonts.actor(fontSize: 14, color: Colors.white),
        //     )),
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
