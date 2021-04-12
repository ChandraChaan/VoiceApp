import 'dart:io';
import 'package:contact_app/music_playe/audio_playe.dart';
import 'package:contact_app/photo_vier/photo_vier.dart';
import 'package:flutter/material.dart';

class SubFolder extends StatefulWidget {
  final String Name_folder;
  SubFolder(this.Name_folder);
  @override
  _SubFolderState createState() => _SubFolderState(this.Name_folder);
}

class _SubFolderState extends State<SubFolder> {
  String name_folder;
  _SubFolderState(this.name_folder);

  var subfolders_list_device = [];

  void _showFilesinDir({Directory? dir}) {
    dir!
        .list(recursive: false, followLinks: false)
        .listen((FileSystemEntity entity) {
      subfolders_list_device.add(entity.path);
    });
  }

  Future subfolder_need() async {
    var systemTempDir = Directory.systemTemp;
    _showFilesinDir(dir: systemTempDir);

    final myDir = new Directory(name_folder);
    myDir.exists().then((isThere) {
      isThere ? _showFilesinDir(dir: myDir) : print('non-existent');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    subfolder_need();
  }

  @override
  Widget build(BuildContext context) {
    subfolder_need();
    print(subfolders_list_device);
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(title: Text(name_folder.substring(8)),),
      body: GridView.builder(
        itemCount: subfolders_list_device.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3),
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: InkWell(
              onTap: () {
                // print(subfolders_list_device[index].substring(subfolders_list_device[index].length - 4));
                if(subfolders_list_device[index].substring(subfolders_list_device[index].length - 4) == '.mp3'){
                  print('This is song');
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => audioplaye(subfolders_list_device[index])),
                  );
                }
                else if(subfolders_list_device[index].substring(subfolders_list_device[index].length - 4) == '.jpg'){
                  print('This is image');
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => photo_vier(subfolders_list_device[index])),
                  );
                }
                else if(subfolders_list_device[index].substring(subfolders_list_device[index].length - 4) == '.pdf'){
                  print('This is pdf');
                }
                else{
                  print('this is unknow file');
                }
              },
              child: Center(child: Text(subfolders_list_device[index].substring(name_folder.length + 1))),
            ),
          );
        },
      ),
    );
  }
}
