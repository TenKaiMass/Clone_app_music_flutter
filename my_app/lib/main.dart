import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
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
        home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [songList()],
        ),
      ),
      bottomNavigationBar: MyBottumBar(),
    );
  }
}

class Cover extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: const BoxDecoration(
          color: Colors.greenAccent,
          image: DecorationImage(
            image: NetworkImage(
                'https://m.media-amazon.com/images/I/71XeBLhY-yL._AC_SX679_.jpg'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50))),
    );
  }
}

class songList extends StatelessWidget {
  final List musicList = [
    {'titre': 'titre1', 'etat': true, 'nom': 'artiste'},
    {'titre': 'titre2', 'etat': false, 'nom': 'artiste2'},
    {'titre': 'titre1', 'etat': true, 'nom': 'artiste'},
    {'titre': 'titre2', 'etat': false, 'nom': 'artiste2'},
    {'titre': 'titre1', 'etat': true, 'nom': 'artiste'},
    {'titre': 'titre2', 'etat': false, 'nom': 'artiste2'},
    
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      
      padding: const EdgeInsets.fromLTRB(30, 40, 20, 20),
      color: Colors.amber,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SizedBox(height: 50),
              Text(
                'liste Musique',
                style: GoogleFonts.aBeeZee(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
          const SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: musicList.map((song) {
              return Container(
                height: 70,
                color: Colors.black12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      song['titre'],
                      style: GoogleFonts.actor(
                          color:
                              song['etat'] ? Colors.deepPurple : Colors.black,
                          fontSize: 24),
                    ),
                    Text(song['nom'], style: GoogleFonts.abel(fontSize: 18)),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class MyBottumBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.deepPurpleAccent,
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.pause,color: Colors.white,),
          label: '',
        ),
        BottomNavigationBarItem(
            label: '',
            icon: Text(
          'le poulet',
          style: GoogleFonts.actor(fontSize: 14,color: Colors.white),
        )),
        const BottomNavigationBarItem(
          icon: Icon(Icons.arrow_upward,color: Colors.white,),
          label: '',
        ),
      ],
    );
  }
}
