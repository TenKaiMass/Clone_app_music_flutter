import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'data_struct.dart';

class PlayerGestion extends StatefulWidget {
  const PlayerGestion({Key? key, required this.mydata}) : super(key: key);
  final MyData mydata;
  @override
  State<StatefulWidget> createState() => PlayerPage();
}

class PlayerPage extends State<PlayerGestion> {
  bool toto = true;

  @override
  Widget build(BuildContext context) {
    Widget image = Stack(children: [
      Container(
        height: 320,
        margin: const EdgeInsets.only(top: 200),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(50),
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 65.0,
              child: Container(
                height: 250,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.grey[350],
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(50),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 50.0,
              child: Container(
                height: 275,
                width: 250,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(widget.mydata.cover),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(50),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ]);

    Widget infSon = Container(
        child: Column(//mainAxisAlignment: MainAxisAlignment.center,
            children: [
      Container(
          margin: EdgeInsets.only(top: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.mydata.titre,
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.w700,
                  fontSize: 25.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 3),
              Text(
                widget.mydata.artiste,
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.0,
                  color: Colors.blue,
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: Slider(
                  value: 1,
                  min: 1.0,
                  max: 100,
                  divisions: 10,
                  activeColor: Colors.blue,
                  inactiveColor: Colors.grey,
                  onChanged: (double newValue) {},
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.shuffle,
                        color: Colors.grey,
                        size: 35,
                      ),
                      onPressed: null,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.skip_previous,
                        color: Colors.black,
                        size: 40,
                      ),
                      onPressed: null,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          toto ? toto = false : toto = true;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Icon(
                          toto ? Icons.pause : Icons.play_arrow,
                          color: Colors.black,
                          size: 40.0,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shape: CircleBorder(),
                        side: BorderSide(
                          width: 1.0,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.skip_next,
                        color: Colors.black,
                        size: 40,
                      ),
                      onPressed: null,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.repeat,
                        color: Colors.grey,
                        size: 35,
                      ),
                      onPressed: null,
                    ),
                  ],
                ),
              )
            ],
          )),
    ]));
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: MyAppBar(),
        body: Container(
            color: Colors.white,
            child: Column(children: [
              Container(child: Column(children: [image, infSon]))
            ])));
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  Size get preferredSize => new Size.fromHeight(60);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.chevron_left,
          color: Colors.black,
          size: 30,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: const [
        IconButton(
          icon: Icon(
            Icons.more_vert,
            color: Colors.white,
            size: 23,
          ),
          onPressed: null,
        )
      ],
      backgroundColor: Colors.white.withOpacity(0),
    );
  }
}
/*

class ImageAuthor extends StatelessWidget {
  const ImageAuthor({Key? key, required this.mydata}) : super(key: key);
  final MyData mydata;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 550,
      child: Stack(children: [
        ArtistPictureSection(
          mydata: mydata,
        ),
      ]),
    );
  }
}

class ArtistPictureSection extends StatelessWidget {
  const ArtistPictureSection({Key? key, required this.mydata})
      : super(key: key);
  final MyData mydata;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 200),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(50),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 65.0,
            child: Container(
              height: 250,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.grey[350],
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(50),
                ),
              ),
            ),
          ),
          Positioned(
            top: 50.0,
            child: Container(
              height: 275,
              width: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(mydata.cover),
                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(50),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PlayerControl extends StatelessWidget {
  const PlayerControl({Key? key, required this.mydata}) : super(key: key);
  final MyData mydata;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PlayingMusicTitle(
            mydata: mydata,
          ),
          MusicSliderSection(
            mydata: mydata,
          ),
          MusicControlButtonSection(
            mydata: mydata,
          )
        ],
      ),
    );
  }
}

class PlayingMusicTitle extends StatelessWidget {
  const PlayingMusicTitle({Key? key, required this.mydata}) : super(key: key);
  final MyData mydata;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          Text(
            mydata.titre,
            style: GoogleFonts.lato(
              fontWeight: FontWeight.w700,
              fontSize: 25.0,
              color: Colors.black,
            ),
          ),
          SizedBox(width: 3),
          Text(
            mydata.artiste,
            style: GoogleFonts.lato(
              fontWeight: FontWeight.w400,
              fontSize: 14.0,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}

class MusicSliderSection extends StatelessWidget {
  const MusicSliderSection({Key? key, required this.mydata}) : super(key: key);
  final MyData mydata;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Slider(
        value: 1,
        min: 1.0,
        max: 100,
        divisions: 10,
        activeColor: Colors.blue,
        inactiveColor: Colors.grey,
        onChanged: (double newValue) {},
      ),
    );
  }
}

// class DurationSection extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(left: 27, right: 27, bottom: 15),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             '1.08',
//             style: GoogleFonts.lato(
//               fontWeight: FontWeight.w400,
//               fontSize: 14.0,
//               color: Colors.grey,
//             ),
//           ),
// Text(
//   '3.14',
//   style: GoogleFonts.lato(
//     fontWeight: FontWeight.w400,
//     fontSize: 14.0,
//     color: Colors.grey,
//   ),
// ),
//         ],
//       ),
//     );
//   }
// }

class MusicControlButtonSection extends StatelessWidget {
  const MusicControlButtonSection({Key? key, required this.mydata})
      : super(key: key);
  final MyData mydata;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(
              Icons.shuffle,
              color: Colors.grey,
              size: 35,
            ),
            onPressed: null,
          ),
          IconButton(
            icon: Icon(
              Icons.skip_previous,
              color: Colors.black,
              size: 40,
            ),
            onPressed: null,
          ),
          ElevatedButton(
            onPressed: () {},
            child: Container(
              padding: EdgeInsets.all(10),
              child: Icon(
                Icons.pause,
                color: Colors.black,
                size: 40.0,
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              shape: CircleBorder(),
              side: BorderSide(
                width: 1.0,
                color: Colors.grey,
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.skip_next,
              color: Colors.black,
              size: 40,
            ),
            onPressed: null,
          ),
          IconButton(
            icon: Icon(
              Icons.repeat,
              color: Colors.grey,
              size: 35,
            ),
            onPressed: null,
          ),
        ],
      ),
    );
  }
}
*/
