import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool playing = false;
  IconData playbtn = Icons.play_arrow;
  AudioPlayer _player;
  AudioCache cache;
  Duration position = new Duration();
  Duration musiclength = new Duration();

  Widget slider() {
    return Container(
      width: 250.0,
      child: Slider.adaptive(
          activeColor: Colors.blue[800],
          inactiveColor: Colors.grey[350],
          value: position.inSeconds.toDouble(),
          max: musiclength.inSeconds.toDouble(),
          onChanged: (value) {
            seekToSec(value.toInt());
          }),
    );
  }

  void seekToSec(int sec) {
    Duration newpos = Duration(seconds: sec);
    _player.seek(newpos);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _player = AudioPlayer();
    cache = AudioCache(fixedPlayer: _player);
    _player.durationHandler = (d) {
      setState(() {
        musiclength = d;
      });
    };
    _player.positionHandler = (p) {
      setState(() {
        position = p;
      });
    };
    //cache.load('girlikeme..mp3');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue[800], Colors.blue[200]]),
        ),
        child: Padding(
          padding: EdgeInsets.only(top:100),
          child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text('Bass Music',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text('Listen to your favorite Music',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w200,
                      )),
                ),
                SizedBox(height: 5),
                Center(
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                        image: AssetImage('assets/cover.png'),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Center(
                  child: Text('Girl like me - Shakira',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      )),
                ),
                SizedBox(height: 5),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 500.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "${position.inMinutes}:${position.inSeconds.remainder(60)}",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                                slider(),
                                Text(
                                  "${musiclength.inMinutes}:${musiclength.inSeconds.remainder(60)}",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                  ]),),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        color: Colors.black,
                                        iconSize: 45,
                                        icon: Icon(Icons.skip_previous),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          if (!playing) {
                                            cache.play('girlikeme.mp3');
                                            setState(() {
                                              playbtn = Icons.pause;
                                              playing = true;
                                            });
                                          } else {
                                            _player.pause();
                                            setState(() {
                                              playbtn = Icons.play_arrow;
                                              playing = false;
                                            });
                                          }
                                        },
                                        color: Colors.black,
                                        iconSize: 62,
                                        icon: Icon(playbtn),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        color: Colors.black,
                                        iconSize: 45,
                                        icon: Icon(Icons.skip_next),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ),]),
                  ),
                ),
    ),
    );
  }
}
