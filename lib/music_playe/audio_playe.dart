import 'package:audioplayers/audio_cache.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

class audioplaye extends StatefulWidget {
  String path_song;

  audioplaye(this.path_song);

  @override
  _audioplayeState createState() => _audioplayeState(this.path_song);
}

class _audioplayeState extends State<audioplaye> {
  String path_song;
_audioplayeState(this.path_song);

  @override
  Widget build(BuildContext context) {
    print(path_song);
    return Scaffold(
      appBar: AppBar(
        title: Text('Music'),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              TextButton(
                  onPressed: () {
                  print('i can not play this moment');
                  },
                  child: Text(
                    'Play',
                    style: TextStyle(fontSize: 23),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
