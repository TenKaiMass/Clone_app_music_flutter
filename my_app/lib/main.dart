import 'package:flutter/material.dart';

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
          children: [Cover(), songList()],
        ),
      ),
    );
  }
}

class Cover extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: const BoxDecoration(
          color: Colors.greenAccent,
          image: DecorationImage(
              image: NetworkImage(
                  'https://m.media-amazon.com/images/I/71XeBLhY-yL._AC_SX679_.jpg'),
                  fit: BoxFit.cover,),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50) 
          )
      ),
    );
  }
}

class songList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      color: Colors.black38,
    );
  }
}
