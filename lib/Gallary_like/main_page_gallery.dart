import 'dart:io';

import 'package:flutter/material.dart';
import 'subfolder.dart';
import 'package:permission_handler/permission_handler.dart';

class main_gallaery_page extends StatefulWidget {
  @override
  _main_gallaery_pageState createState() => _main_gallaery_pageState();
}

class _main_gallaery_pageState extends State<main_gallaery_page> {
  var folders_list_device = [];

  void _showFilesinDir({Directory? dir}) {
    dir!
        .list(recursive: false, followLinks: false)
        .listen((FileSystemEntity entity) {
      folders_list_device.add(entity.path);
    });
  }

  Future Permission_need() async {
    var systemTempDir = Directory.systemTemp;
    _showFilesinDir(dir: systemTempDir);

    final myDir = new Directory('/sdcard');
    myDir.exists().then((isThere) {
      isThere ? _showFilesinDir(dir: myDir) : print('non-existent');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Permission_need();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return GridView.builder(
      itemCount: folders_list_device.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3),
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: InkWell(
            onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SubFolder(folders_list_device[index])),
                );
            },
            child: Center(child: Text(folders_list_device[index].substring(8))),
          ),
        );
      },
    );
  }
}
