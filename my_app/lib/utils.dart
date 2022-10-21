import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/cloud.dart';

import 'auth.dart';
import 'storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class MyAppBar1 extends StatelessWidget implements PreferredSizeWidget {
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
    );
  }
}

class MyAppBar2 extends StatelessWidget implements PreferredSizeWidget {
  final User? user = Auth(auth: FirebaseAuth.instance).currentUser;

  Future<void> signOut() async {
    await Auth(auth: FirebaseAuth.instance).signOut();
  }

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
                  context, MaterialPageRoute(builder: (context) => Scaffold()));
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            color: Colors.white,
            onPressed: () {
              signOut();
            },
          ),
        ]);
  }
}
