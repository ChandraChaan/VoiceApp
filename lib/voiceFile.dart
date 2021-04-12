import 'dart:async';
import 'dart:math';
import 'package:battery/battery.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';

class Voicepage extends StatefulWidget {
  @override
  _VoicepageState createState() => _VoicepageState();
}

class _VoicepageState extends State<Voicepage> {
  final Battery _battery = Battery();

  BatteryState? _batteryState;

  @override
  void initState() {
    super.initState();
        _battery.onBatteryStateChanged.listen((BatteryState state) {
          setState(() {
            _batteryState = state;
          });
        });
  }


  @override
  void dispose() {
    super.dispose();
  }


  List colors = [Colors.white, Colors.red, Colors.green, Colors.yellow, Colors.black, Colors.purple, Colors.orange, Colors.blue, Colors.blueGrey, Colors.grey];
  Random random = new Random();

  int index = 0;
  double marginvalue = 1;
  void changeIndex() async {
    final int batteryLevel = await _battery.batteryLevel;
    var Msg =  batteryLevel == null ? 'no battery' : batteryLevel;
    print('this is battery ');
    print (batteryLevel);

    setState(() => index = random.nextInt(colors.length));
    if(marginvalue <= Responcesize){
      print('Now it is using marginvalue: ${marginvalue}');
    }
    else{
      print('it is not using the marginvalue: ${marginvalue}');

      marginvalue ==1 ? null :_showMyDialog();

    }
  }

  double Responcesize = 0;

  Future<void> _showMyDialog() async {
    final int batteryLevel = await _battery.batteryLevel;
    var Msg =  batteryLevel == null ? 'no battery' : batteryLevel;
    print('this is battery ');
    print (batteryLevel);
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: colors[index],
          title: Text('Battery: $Msg%', style: TextStyle(color: colors[index] == Colors.white ? Colors.black : Colors.white),),
          actions: <Widget>[
            TextButton(
              child: Text('OK', style: TextStyle(color: colors[index] == Colors.white ? Colors.black : Colors.white),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white10,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              // color: Colors.deepPurpleAccent,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black12,
              ),
              margin: EdgeInsets.all(marginvalue <= Responcesize ? marginvalue : Responcesize),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: MediaQuery.of(context).size.width/2,
                  child: Row(
                    children: [
                      Expanded(flex:2, child: Text('Voice',
                        style: TextStyle(fontSize:MediaQuery.of(context).size.width <800 ? (MediaQuery.of(context).size.width <610 ? (MediaQuery.of(context).size.width < 376 ? (MediaQuery.of(context).size.width < 300 ? 25:30) : (MediaQuery.of(context).size.width < 420 ? 40 :50)) : 65) :(MediaQuery.of(context).size.width <1200 ? (MediaQuery.of(context).size.width < 920 ? 80 :100) : 160),
                            color: colors[index]),
                      )
                      ),
                      Expanded (flex:2,child: IconButton(icon: Icon(Icons.mic), onPressed: () {
                        changeIndex();
                        setState(() {
                          Responcesize = (MediaQuery.of(context).size.width <800 ? (MediaQuery.of(context).size.width <610 ? (MediaQuery.of(context).size.width < 376 ? (MediaQuery.of(context).size.width < 300 ? 25:30) : (MediaQuery.of(context).size.width < 420 ? 40 :50)) : 65) :(MediaQuery.of(context).size.width <1200 ? (MediaQuery.of(context).size.width < 920 ? 80 :100) : 160));
                          marginvalue++;
                        });
                      },
                          iconSize: MediaQuery.of(context).size.width <800 ? (MediaQuery.of(context).size.width <610 ? (MediaQuery.of(context).size.width < 376 ? (MediaQuery.of(context).size.width < 300 ? 25:30) : (MediaQuery.of(context).size.width < 420 ? 40 :50)) : 65) :(MediaQuery.of(context).size.width <1200 ? (MediaQuery.of(context).size.width < 920 ? 80 :100) : 200), color: colors[index])
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
      ),
    );
  }
}