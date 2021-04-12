import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

class Contacts_PA extends StatefulWidget {
  @override
  _Contacts_PAState createState() => _Contacts_PAState();
}

class _Contacts_PAState extends State<Contacts_PA> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.pink,
        ),
        child: Text(
          'Give Me Perimssions',
          style: TextStyle(fontSize: 30),
        ),
        onPressed: (){
          openAppSettings();
        },
      ),
    );
  }
}
