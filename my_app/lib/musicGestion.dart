// import 'package:flutter/cupertino.dart';
// import 'package:audioplayers/audioplayers.dart';


// class ExampleApp extends StatefulWidget {
//   @override
//   _ExampleAppState createState() => new _ExampleAppState();
// }

// class _ExampleAppState extends State<ExampleApp> {
//   Duration _duration = new Duration();
//   Duration _position = new Duration();
//   late AudioPlayer advancedPlayer;
//   late AudioCache audioCache;

//   @override
//   void initState(){
//     super.initState();
//     initPlayer();
//   }


//   void initPlayer(){
//     advancedPlayer =  AudioPlayer();
//     audioCache = AudioCache(fixedPlayer: advancedPlayer);

//     advancedPlayer.durationHandler = (d) => setState(() {
//       _duration = d;
//     });

//     advancedPlayer.positionHandler = (p) => setState(() {
//     _position = p;
//     });
//   }
//    Widget localAsset() {
//     return _tab([
//       Text('Play Local Asset \'audio.mp3\':'),
//       _btn('Play', () => audioCache.play('audio.mp3')),
//       _btn('Pause',() => advancedPlayer.pause()),
//       _btn('Stop', () => advancedPlayer.stop()),
//       slider()
//     ]);
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }

// }
