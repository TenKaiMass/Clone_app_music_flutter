import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/storage.dart';
import 'data_struct.dart';

class PlayerGestion extends StatefulWidget {
  const PlayerGestion(
      {Key? key, required this.mydata, required this.snapshotFromDesier})
      : super(key: key);
  final QueryDocumentSnapshot mydata;
  final AsyncSnapshot<String> snapshotFromDesier;
  @override
  State<StatefulWidget> createState() => PlayerPage();
}

class PlayerPage extends State<PlayerGestion> {
  Stockage storage = Stockage();
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  AudioPlayer? advancedPlayer;
  AudioCache? audioCache;
  bool isPlayed = false;

  String formaTime(Duration d) {
    if (d == null) {
      return "--:--";
    } else {
      var min = d.inMinutes.toString().padLeft(2, '0');
      var sec = d.inSeconds.remainder(60).toString().padLeft(2, '0');
      return "$min:$sec";
    }
  }

  initPlayer() {
    advancedPlayer = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: advancedPlayer);
  }

  Future setAudio() async {
    //audioCache = AudioCache(prefix: '');
    var url = await storage.getItemFromCloud(widget.mydata['chemin_music']);
    //final url = await audioCache?.load(widget.mydata['chemin_music']);
    advancedPlayer?.setUrl(url, isLocal: false);
  }

  @override
  void initState() {
    super.initState();
    initPlayer();
    setAudio();
    advancedPlayer?.onPlayerStateChanged.listen((state) {
      isPlayed = state == PlayerState.PLAYING;
    });
    advancedPlayer?.onDurationChanged.listen((event) {
      setState(() {
        _duration = event;
      });
    });
    advancedPlayer?.onAudioPositionChanged.listen((event) {
      setState(() {
        _position = event;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

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
                    image: NetworkImage(widget.snapshotFromDesier.data!),
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
                widget.mydata['titre'],
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.w700,
                  fontSize: 25.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 3),
              Text(
                widget.mydata['artiste'],
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.0,
                  color: Colors.blue,
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: Slider(
                  value: _position.inSeconds.toDouble(),
                  min: 0,
                  max: _duration.inSeconds.toDouble(),
                  divisions: 10,
                  activeColor: Colors.blue,
                  inactiveColor: Colors.grey,
                  onChanged: (value) async {
                    final position = Duration(seconds: value.toInt());
                    await advancedPlayer?.seek(position);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(formaTime(_position)),
                    Text(formaTime(_duration - _position))
                  ],
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
                      onPressed: () async {
                        isPlayed
                            ? advancedPlayer?.pause()
                            : advancedPlayer?.resume();
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Icon(
                          isPlayed ? Icons.pause : Icons.play_arrow,
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
          Icons.arrow_drop_down_outlined,
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
