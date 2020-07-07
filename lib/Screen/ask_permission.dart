import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter_aos/Utils/Services.dart';

import 'main_menu.dart';

class AskPermission extends StatefulWidget {
  @override
  _AskPermissionState createState() => _AskPermissionState();
}

class _AskPermissionState extends State<AskPermission> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Apps Permission",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.red,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(48, 20, 48, 20),
                    child: AutoSizeText(
                      "Kami membutuhkan izin Anda untuk mengakses beberapa informasi ",
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  _createRowPermission(Icons.pin_drop, "Lokasi",
                      "Untuk mengakses Lokasi anda"),
                  _createRowPermission(Icons.camera_alt, "Kamera",
                      "Untuk mengakses Kamera Anda"),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 30),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  //  EdgeInsets.only(left: 20.0, right: 20.0),
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      child: Text(
                        "Izinkan",
                        style: new TextStyle(fontSize: 14),
                      ),
                    ),
                    onPressed: () {
                      getPermission();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => MyHomePage(),
                        ),
                      );
                    },
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _createRowPermission(
      IconData _icons, String _headerText, String _subheaderText) {
    return Padding(
      padding: EdgeInsets.fromLTRB(24, 12, 24, 0),
      child: Row(
        children: <Widget>[
//          Padding(
//            padding: EdgeInsets.fromLTRB(
//                20, 0, 20, 20),
//            child: Icon(
//              _icons,
//              size: 24,
//            ),
//          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
                20, 0, 20, 22),
            child: Container(
              width: 25,
              height: 25,
              margin: EdgeInsets.only(top: 15),
              child: Icon(_icons),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _headerText,
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Text(_subheaderText, style: TextStyle(color: Colors.black),)
              ],
            ),
          )
        ],
      ),
    );
  }
}
