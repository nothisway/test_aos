import 'dart:async';

import 'package:flutter/material.dart';
import 'login.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {

  double statbarH = 0;


  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 1), onDoneLoading);
  }

  onDoneLoading() async {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          opaque: true,
          transitionDuration: Duration(seconds: 3),
          pageBuilder: (BuildContext ctx, _, __) => Login(),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Image.asset('assets/aos_logo.png'),
        )
      ),
    );
  }
}
