import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
class photo_vier extends StatefulWidget {
  String path_image;
  photo_vier(this.path_image);
  @override
  _photo_vierState createState() => _photo_vierState(this.path_image);
}

class _photo_vierState extends State<photo_vier> {
  String path_image;
  _photo_vierState(this.path_image);

  @override
  Widget build(BuildContext context) {
    print(path_image);
    return Scaffold(
      appBar: AppBar(title: Text('Photo View'),),
      body: PhotoView(
        imageProvider: FileImage(new File(path_image)),
      ),
    );
  }
}
